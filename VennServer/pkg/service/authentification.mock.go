// +build mock

package service

import (
	"context"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

type authentificationServiceServer struct {
}

func NewAuthentificationServiceServer() proto.AuthentificationServiceServer {
	return &authentificationServiceServer{}
}

func (s *authentificationServiceServer) ReadUserList(ctx context.Context, e *proto.Empty) (*proto.Users, error) {
	return nil, nil
}
func (s *authentificationServiceServer) UpdateCurrentUser(ctx context.Context, u *proto.User) (*proto.Empty, error) {
	return nil, nil
}

// func (s *authentificationServiceServer) Authentificate(ctx context.Context, cred *proto.Credentials) (*proto.Empty, error) {
// 	if cred == nil {
// 		return &proto.Empty{},
// 			status.Error(codes.InvalidArgument, "credentials cannot be null")
// 	}
// 	found, err := auth.Verify(ctx, cred.GetUser(), cred.GetPassword())
// 	if err != nil {
// 		return &proto.Empty{}, status.Error(codes.Internal, err.Error())
// 	}
// 	if !found {
// 		return &proto.Empty{}, fmt.Errorf("user-password combination not found")
// 	}
// 	return &proto.Empty{}, nil
// }
