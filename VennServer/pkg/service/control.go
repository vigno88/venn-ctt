// +build production

package service

import (
	"context"
	"fmt"
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

func (s *controlServiceServer) Send(c context.Context, a *proto.Action) (*proto.SendResponse, error) {
	switch a.Name {
	case "piston":
		// Directly send the payload to the board as a string, TODO - nanopb
		// The string is format as "piston #"#"action"
		// fmt.Println("Send: " + a.Payload)
		serial.SendString(a.Payload)
		return &proto.SendResponse{}, nil
	case "home":
		if motors.IsCycling() {
			fmt.Println("Cannot home the motors, they are currently cycling.")
			return &proto.SendResponse{Error: "Cannot home the motors, they are currently cycling."}, nil
		}
		if motors.IsHoming() {
			fmt.Println("Cannot home the motors, they are already currently homing.")
			return &proto.SendResponse{Error: "Cannot home the motors, they are already currently homing."}, nil
		}
		fmt.Println("Trying to home the motors")
		// Ask the motors to home
		// TODO - check that the motor is not currently moving
		go motors.Home()
		return &proto.SendResponse{}, nil
	case "cycle":
		if a.Payload == "start" {
			if motors.IsHoming() {
				return &proto.SendResponse{Error: "Cannot start the cycle, the motors are homing."}, nil
			}
			fmt.Println("Received start command from UI")
			motors.StartCycle()
		}
		if a.Payload == "stop" {
			if motors.IsHoming() {
				return &proto.SendResponse{Error: "Cannot stop the cycle, the motors are homing."}, nil
			}
			fmt.Println("Received stop command from UI")
			motors.StopCycle()
		}
		return &proto.SendResponse{}, nil
	case "water":
		// Directly send the payload to the board as a string, TODO - nanopb
		// The string is format as w#"action"
		// fmt.Println("Send: " + a.Payload)
		serial.SendString(a.Payload)
		return &proto.SendResponse{}, nil
	}
	return &proto.SendResponse{}, nil
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
