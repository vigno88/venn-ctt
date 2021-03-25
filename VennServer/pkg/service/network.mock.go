// +build mock

package service

import (
	"context"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type networkServiceServer struct {
}

func NewNetworkServiceServer() proto.NetworkServiceServer {
	return &networkServiceServer{}
}

func (s *networkServiceServer) ReadWifiList(ctx context.Context, e *proto.Empty) (*proto.WifiNames, error) {
	return nil, nil
}

func (s *networkServiceServer) ConnectWifi(ctx context.Context, cred *proto.WifiCredentials) (*proto.Empty, error) {
	if cred == nil {
		return &proto.Empty{}, status.Error(codes.InvalidArgument, "credentials are missing")

	}

	return &proto.Empty{}, nil
}
