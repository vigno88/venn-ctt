// +build production

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/motors"
	"github.com/vigno88/Venn/VennServer/pkg/serial"
)

// metricServiceServer is implementation of proto.metricServiceServer proto interface
type controlServiceServer struct {
	controlChan chan *proto.ControlEvent
}

func NewControlServiceServer(c chan *proto.ControlEvent) proto.ControlServiceServer {
	return &controlServiceServer{c}
}

func (s *controlServiceServer) Send(c context.Context, a *proto.Action) (*proto.Empty, error) {
	switch a.Name {
	case "piston":
		// Directly send the payload to the board as a string, TODO - nanopb
		// The string is format as "piston #"#"action"
		serial.SendString(a.Payload)
		break
	case "home":
		// Ask the motors to home
		// TODO - check that the motor is not currently moving
		motors.Home()
		return nil, nil
	case "cycle":
		if a.Payload == "start" {
			// TODO - add errors motors
			motors.StartCycle()
		}
		if a.Payload == "stop" {
			motors.StopCycle()
		}
		return nil, nil
	case "water":
		// Directly send the payload to the board as a string, TODO - nanopb
		// The string is format as w#"action"
		serial.SendString(a.Payload)
		return nil, nil
	}
	return nil, nil
}

func (s *controlServiceServer) Subscribe(e *proto.Empty, stream proto.ControlService_SubscribeServer) error {
	log.Print("Control Subscribe requested")
	for {
		c := <-s.controlChan
		// metrics.Put(context.Background(), m)
		if err :=
			stream.Send(c); err != nil {
			// put message back to the channel
			s.controlChan <- c
			log.Printf("Control stream connection failed: %v", err)
			return nil
		}
	}
}
