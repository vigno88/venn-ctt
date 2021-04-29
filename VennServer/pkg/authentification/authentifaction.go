// +build production mock

package authentifaction

import (
	"context"
	"fmt"
	"log"

	"github.com/asdine/storm/v3"
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

var pathDB string

const currentKey = "current"
const keyValueName = "users"

const (
	USER_TYPE    = `user`
	ADMIN_TYPE   = `admin`
	CREATOR_TYPE = `creator`
)

type User struct {
	Title    string `storm:"id"`
	Type     string
	Password string
}

func Init(ctx context.Context, path string) error {
	pathDB = path
	log.Printf("Initiating authentifaction store at %s", pathDB)
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	// db.Init(&User{})
	db.Close()
	return nil
}

func protoToUser(u *proto.User) *User {
	var t string
	switch u.Role {
	case proto.User_ADMIN:
		t = ADMIN_TYPE
		break
	case proto.User_CREATOR:
		t = CREATOR_TYPE
		break
	case proto.User_USER:
		t = USER_TYPE
		break
	}
	return &User{
		Title: u.Title,
		Type:  t,
	}
}

func UserToProto(u *User) *proto.User {
	var t proto.User_Roles
	switch u.Type {
	case ADMIN_TYPE:
		t = proto.User_ADMIN
		break
	case USER_TYPE:
		t = proto.User_USER
		break
	case CREATOR_TYPE:
		t = proto.User_CREATOR
		break
	}
	return &proto.User{Title: u.Title, Role: t}
}

func CreateUser(u *User) error {
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Save(u)
	if err == nil {
		return err
	}
	return nil
}

func ReadUsers() ([]User, error) {
	db, err := storm.Open(pathDB)
	if err != nil {
		return nil, err
	}
	defer db.Close()
	var users []User
	err = db.All(&users)
	if err != nil {
		return nil, err
	}
	return users, nil
}

func UpdateCurrentUser(name string) error {
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Set(keyValueName, currentKey, name)
	if err != nil {
		return err
	}
	return err
}

func ReadCurrentUser() (string, error) {
	db, err := storm.Open(pathDB)
	if err != nil {
		return "", err
	}
	defer db.Close()
	var name string
	err = db.Get(keyValueName, currentKey, &name)
	if err != nil {
		return "", err
	}
	return name, nil
}

func ReadUser(name string) (*User, error) {
	db, err := storm.Open(pathDB)
	if err != nil {
		return nil, err
	}
	defer db.Close()
	user := User{}
	fmt.Printf("Trying to read user : %s", name)
	err = db.One("Title", name, &user)
	if err != nil {
		return nil, err
	}
	return &user, nil
}
