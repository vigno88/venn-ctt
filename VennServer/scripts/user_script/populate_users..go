package populateUsers

import (
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
)

func main() {
	// Create the 3 basic users
	authentifaction.CreateUser(&proto.User{Title: "Admin", Role: proto.User_ADMIN})
	authentifaction.CreateUser(&proto.User{Title: "God", Role: proto.User_CREATOR})
	authentifaction.CreateUser(&proto.User{Title: "User", Role: proto.User_USER})

	// Set the current users
	authentifaction.UpdateCurrentUser("User")
}
