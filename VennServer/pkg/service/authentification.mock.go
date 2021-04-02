// +build mock

package service

import (
	"context"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

type authentificationServiceServer struct {
}

var currentUser *proto.User

func NewAuthentificationServiceServer() proto.AuthentificationServiceServer {
	currentUser = &proto.User{Title: "User", Role: proto.User_USER}
	return &authentificationServiceServer{}
}

func (s *authentificationServiceServer) ReadUserList(ctx context.Context, e *proto.Empty) (*proto.Users, error) {
	return &proto.Users{Users: []*proto.User{
		{Title: "User", Role: proto.User_USER},
		{Title: "Administrator", Role: proto.User_ADMIN},
		{Title: "God", Role: proto.User_CREATOR},
	}}, nil
}
func (s *authentificationServiceServer) UpdateCurrentUser(ctx context.Context, u *proto.User) (*proto.Empty, error) {
	currentUser = u
	return nil, nil
}

func (s *authentificationServiceServer) GetCurrentUser(ctx context.Context, e *proto.Empty) (*proto.User, error) {
	return currentUser, nil
}
