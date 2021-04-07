package main

import (
	"context"
	"log"

	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func main() {
	err := authentifaction.Init(context.Background(), util.PathAuth)
	if err != nil {
		log.Printf("Error while authenticating: %s\n", err.Error())
	}
	// Create the 3 basic users
	err = authentifaction.CreateUser(&authentifaction.User{
		Title:    "Admin",
		Type:     authentifaction.ADMIN_TYPE,
		Password: "",
	})
	if err != nil {
		log.Printf("Error while creating user: %s\n", err.Error())
	}
	err = authentifaction.CreateUser(&authentifaction.User{
		Title:    "God",
		Type:     authentifaction.CREATOR_TYPE,
		Password: "",
	})
	if err != nil {
		log.Printf("Error while creating user: %s\n", err.Error())
	}
	err = authentifaction.CreateUser(&authentifaction.User{
		Title:    "User",
		Type:     authentifaction.USER_TYPE,
		Password: "",
	})
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
