package serial

import (
	"bufio"
	"context"
	"fmt"
	"log"
	"strconv"
	"strings"
	"time"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/configuration"

	// "github.com/vigno88/Venn/VennServer/pkg/service"
	"go.bug.st/serial"
)

type serialManager struct {
	Port     serial.Port
	Response map[string]chan string
	ToSend   chan string
	Received chan string
	ErrChan  chan error
	gRPCChan chan *proto.MetricUpdates
}

var manager serialManager

func Init(ctx context.Context, c chan *proto.MetricUpdates) error {
	p, err := manager.openPort()
	if err != nil {
		return err
	}
	mapChan := make(map[string]chan string)
	mapChan["setting"] = make(chan string)
	manager = serialManager{
		Port:     p,
		Response: mapChan,
		Received: make(chan string),
		ErrChan:  make(chan error),
		ToSend:   make(chan string),
		gRPCChan: c,
	}
	return nil
}

func (m *serialManager) openPort() (serial.Port, error) {
	mode := &serial.Mode{
		BaudRate: 115200,
	}
	port, err := serial.Open("/dev/serial0", mode)
	if err != nil {
		log.Fatal(err)
		return nil, err
	}
	log.Printf("Serial port opened\n")
	return port, nil
}

func Run(ctx context.Context, exit chan<- string) {
	stopRead := make(chan string)
	go manager.readPort(stopRead)
	for {
		select {
		case request := <-manager.ToSend:
			_, err := manager.Port.Write([]byte(request + "\n"))
			log.Printf("Print %s to the serial port\n", request[:len(request)-1])
			if err != nil {
				manager.ErrChan <- fmt.Errorf("Error writing port: %v", err)
				stopRead <- "done"
				return
			}
		case received := <-manager.Received:
			manager.process(ctx, received)
		case err := <-manager.ErrChan:
			log.Printf("Error: %v\n", err)
		}
	}
}

func SendSetting(setting *proto.Setting) {
	SendString(fmt.Sprintf("p#%s#%d", configuration.GetSmallNameSetting(setting.GetName()), int(setting.GetValue())))
}

func SendString(s string) {
	manager.ToSend <- s
}

func (m *serialManager) readPort(stop <-chan string) {
	log.Printf("Starting to read the serial port\n")
	serialReader := bufio.NewReader(m.Port)
	for {
		select {
		case <-stop:
			return
		default:
			payload, err := serialReader.ReadString('\n')
			if err != nil {
				log.Printf("Error reading from the serial port: %v\n", err)
				m.ErrChan <- fmt.Errorf("Error reading from the serial port: %v\n", err)
			}
			payload = payload[:len(payload)-1]
			m.Received <- payload
			time.Sleep(time.Millisecond)
		}
	}
}

func (m *serialManager) process(ctx context.Context, packet string) error {
	if strings.Contains(packet, "ok") {
		log.Print("Received the ok response")
		return nil
	}
	// If string is a metric, send the metric package
	parts := strings.Split(packet, "#")
	if len(parts) != 3 {
		log.Printf("Payload invalid: %s\n", packet)
		return fmt.Errorf("Payload invalid: %s\n", packet)
	}
	if strings.Contains(parts[0], "m") {
		f, err := strconv.ParseFloat(parts[2], 64)
		if err != nil {
			return err
		}
		metric := &proto.MetricUpdate{}
		metric.Name = configuration.GetNameMetric(parts[1])
		metric.Target = configuration.GetGoal(metric.Name)
		metric.Value = f
		manager.gRPCChan <- metric
	}
	return nil
}
