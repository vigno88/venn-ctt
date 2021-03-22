// +build production

package service

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/configuration"
)

type configurationServiceServer struct {
}

func NewConfigurationServiceServer() proto.ConfigurationServiceServer {
	return &configurationServiceServer{}
}

func (s *configurationServiceServer) GetConfig(ctx context.Context, e *proto.Empty) (*proto.Configuration, error) {
	log.Printf("Frontend ask for the configuration")
	return configuration.GetConfig(ctx), nil
}

func (s *configurationServiceServer) SetConfig(ctx context.Context, config *proto.Configuration) (*proto.Empty, error) {
	configuration.SetMetricsConfig(config)
	return &proto.Empty{}, nil
}
