// +build mock

package service

import (
	"context"
	"fmt"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
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
		fmt.Printf("Received piston command: %s\n", a.Payload)
		return &proto.SendResponse{}, nil
	case "home":
		fmt.Println("Received motor homing command")
		return &proto.SendResponse{}, nil
	case "cycle":
		if a.Payload == "start" {
			fmt.Println("Received start command from UI")
		}
		if a.Payload == "stop" {
			fmt.Println("Received stop command from UI")
		}
		return &proto.SendResponse{}, nil
	case "water":
		fmt.Printf("Received water command: %s\n", a.Payload)
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
