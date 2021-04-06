package main

import (
	"context"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func main() {
	err := authentifaction.Init(context.Background(), util.PathAuth)
	if err != nil {
		log.Printf("Error while authenticating: %s\n", err.Error())
	}
	// Create the 3 basic users
	err = authentifaction.CreateUser(&proto.User{Title: "Admin", Role: proto.User_ADMIN})
	if err != nil {
		log.Printf("Error while creating user: %s\n", err.Error())
	}
	err = authentifaction.CreateUser(&proto.User{Title: "God", Role: proto.User_CREATOR})
	if err != nil {
		log.Printf("Error while creating user: %s\n", err.Error())
	}
	err = authentifaction.CreateUser(&proto.User{Title: "User", Role: proto.User_USER})
	if err != nil {
		log.Printf("Error while creating user: %s\n", err.Error())
	}

	// Set the current users
	err = authentifaction.UpdateCurrentUser("User")
	if err != nil {
		log.Printf("Error while updating current user: %s\n", err.Error())
	}
	log.Println("Default user setup done")
}
