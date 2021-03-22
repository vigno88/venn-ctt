// +build mock

package service

import (
	"context"
	"fmt"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	auth "github.com/vigno88/Venn/VennServer/pkg/authentification"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/status"
)

type authentificationServiceServer struct {
}

func NewAuthentificationServiceServer() proto.AuthentificationServiceServer {
	return &authentificationServiceServer{}
}

func (s *authentificationServiceServer) Authentificate(ctx context.Context, cred *proto.Credentials) (*proto.Empty, error) {
	if cred == nil {
		return &proto.Empty{},
			status.Error(codes.InvalidArgument, "credentials cannot be null")
	}
	found, err := auth.Verify(ctx, cred.GetUser(), cred.GetPassword())
	if err != nil {
		return &proto.Empty{}, status.Error(codes.Internal, err.Error())
	}
	if !found {
		return &proto.Empty{}, fmt.Errorf("user-password combination not found")
	}
	return &proto.Empty{}, nil
}
