package main

import (
	"context"
	"fmt"
	"os"
	"runtime/debug"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/orchestrator"
	"github.com/vigno88/Venn/VennServer/pkg/protocol/grpc"
	"github.com/vigno88/Venn/VennServer/pkg/service"
)

func main() {
	// metricChannel is used to send stream data to gRPC API
	metricChan := make(chan *proto.MetricUpdate, 200)
	go orchestrator.Run(context.Background(), metricChan)
	if err := grpc.RunServer(context.Background(),
		service.NewMetricServiceServer(metricChan),
		service.NewSettingServiceServer(),
		service.NewAuthentificationServiceServer(),
		service.NewNetworkServiceServer(),
		service.NewConfigurationServiceServer(), "3000"); err != nil {
		fmt.Fprintf(os.Stderr, "%v\n", err)
		debug.PrintStack()
		os.Exit(1)
	}
}
