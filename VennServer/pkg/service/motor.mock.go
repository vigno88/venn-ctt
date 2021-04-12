// +build mock

package service

import (
	"context"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

type motorControlServiceServer struct {
}

func MotorControlServiceServer() proto.MotorControlServiceServer {
	return &motorControlServiceServer{}
}

func (s *motorControlServiceServer) Home(ctx context.Context, e *proto.Empty) (*proto.Empty, error) {
	return &proto.Empty{}, nil
}

func (s *motorControlServiceServer) StartCycle(ctx context.Context, e *proto.Empty) (*proto.Empty, error) {
	return &proto.Empty{}, nil
}

func (s *motorControlServiceServer) StopCycle(ctx context.Context, e *proto.Empty) (*proto.Empty, error) {
	return &proto.Empty{}, nil
}
