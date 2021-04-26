// +build production

package service

import (
	"context"
	"fmt"
	"log"

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

func (s *networkServiceServer) ReadWifiList(ctx context.Context, e *proto.Empty) (*proto.WifiNames, error) {
	list, err := wifi.ReadWifiList()
	if err != nil {
		log.Printf("Error while reading wifi list: %s\n", err.Error())
		return nil, err
	}
	return &proto.WifiNames{SSIDs: list}, nil
}

func (s *networkServiceServer) ConnectWifi(ctx context.Context, cred *proto.WifiCredentials) (*proto.Empty, error) {
	if cred == nil {
		return &proto.Empty{}, status.Error(codes.InvalidArgument, "credentials are missing")
	}
	err := wifi.Connect(cred.SSID, cred.Password)
	if err != nil {
		log.Printf("Error while trying to connect to wifi: %s\n", err.Error())
		return nil, fmt.Errorf("Error while trying to connect to wifi: %s", cred.SSID)
	}
	return &proto.Empty{}, nil
}

func (s *networkServiceServer) ReadStatus(ctx context.Context, e *proto.Empty) (*proto.WifiStatus, error) {
	isConnected, ssid := wifi.ReadStatus()
	return &proto.WifiStatus{IsConnected: isConnected, SSID: ssid}, nil
}
