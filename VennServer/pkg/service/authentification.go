// +build production

package service

import (
	"context"
	"fmt"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
)

type authentificationServiceServer struct {
}

func NewAuthentificationServiceServer() proto.AuthentificationServiceServer {
	return &authentificationServiceServer{}
}

func (s *authentificationServiceServer) ReadUserList(ctx context.Context, e *proto.Empty) (*proto.Users, error) {
	users, err := authentifaction.ReadUsers()
	if err != nil {
		log.Printf("Error while reading users list: %s", err.Error())
		return nil, err
	}
	u := []*proto.User{}
	for _, v := range users {
		u = append(u, authentifaction.UserToProto(&v))
	}
	return &proto.Users{Users: u}, nil
}

func (s *authentificationServiceServer) UpdateCurrentUser(ctx context.Context, u *proto.User) (*proto.Empty, error) {
	err := authentifaction.UpdateCurrentUser(u.Title)
	if err != nil {
		log.Printf("Error while updating current user: %s", err.Error())
		return nil, err
	}
	return nil, nil
}

func (s *authentificationServiceServer) GetCurrentUser(ctx context.Context, e *proto.Empty) (*proto.User, error) {
	name, err := authentifaction.ReadCurrentUser()
	if err != nil {
		log.Printf("Error while reading current user: %s", err.Error())
		return nil, err
	}
	u, err := authentifaction.ReadUser(name)
	if err != nil {
		log.Printf("Error while reading user: %s", err.Error())
		return nil, err
	}
	fmt.Printf("%v\n", u)
	return authentifaction.UserToProto(u), nil
}
