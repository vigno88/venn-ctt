// +build mock

package service

import (
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

type configurationServiceServer struct {
}

func NewConfigurationServiceServer() proto.ConfigurationServiceServer {
	return &configurationServiceServer{}
}
