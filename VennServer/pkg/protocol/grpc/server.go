package grpc

import (
	"context"
	"log"
	"net"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"google.golang.org/grpc"
)

// RunServer registers gRPC service and run server
func RunServer(ctx context.Context, metric proto.MetricServiceServer,
	setting proto.SettingServiceServer, auth proto.AuthentificationServiceServer,
	network proto.NetworkServiceServer, config proto.ConfigurationServiceServer,
	control proto.ControlServiceServer, port string) error {
	listen, err := net.Listen("tcp", ":"+port)
	if err != nil {
		return err
	}

	// register the services
	server := grpc.NewServer()
	proto.RegisterMetricServiceServer(server, metric)
	proto.RegisterSettingServiceServer(server, setting)
	proto.RegisterAuthentificationServiceServer(server, auth)
	proto.RegisterNetworkServiceServer(server, network)
	proto.RegisterConfigurationServiceServer(server, config)
	proto.RegisterControlServiceServer(server, control)

	// start gRPC server
	log.Printf("starting gRPC server on port: %s\n", port)
	return server.Serve(listen)
}
