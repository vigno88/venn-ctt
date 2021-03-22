// +build mock

package service

import (
	"context"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/wifi"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type networkServiceServer struct {
}

func NewNetworkServiceServer() proto.NetworkServiceServer {
	return &networkServiceServer{}
}

func (s *networkServiceServer) ConnectWifi(ctx context.Context, cred *proto.WifiCredentials) (*proto.Empty, error) {
	if cred == nil {
		return &proto.Empty{}, status.Error(codes.InvalidArgument, "credentials are missing")

	}
	err := wifi.Connect(ctx, cred.GetName(), cred.GetPassword())
	if err != nil {
		return &proto.Empty{}, status.Error(codes.DeadlineExceeded, err.Error())
	}
	return &proto.Empty{}, nil
}
