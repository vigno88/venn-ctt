// +build production

package authentifaction

import (
	"context"
	"log"

	"github.com/asdine/storm/v3"
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

var pathDB string
var bucketName string

const currentKey = "current"
const keyValueName = "users"

const (
	USER    = `user`
	ADMIN   = `admin`
	CREATOR = `creator`
)

type User struct {
	Title    string `storm:"id"`
	Type     string
	Password string
}

func Init(ctx context.Context, path string) error {
	pathDB = path
	log.Printf("Initiating authentifaction store at %s", pathDB)
	return nil
}

func protoToUser(u *proto.User) *User {
	var t string
	switch u.Role {
	case proto.User_ADMIN:
		t = ADMIN
		break
	case proto.User_CREATOR:
		t = CREATOR
		break
	case proto.User_USER:
		t = USER
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
	case ADMIN:
		t = proto.User_ADMIN
		break
	case USER:
		t = proto.User_USER
		break
	case CREATOR:
		t = proto.User_CREATOR
		break
	}
	return &proto.User{Title: u.Title, Role: t}
}

func CreateUser(u *proto.User) error {
	db, err := storm.Open("my.db")
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Save(protoToUser(u))
	if err == nil {
		return err
	}
	return nil
}

func ReadUsers() ([]*proto.User, error) {
	db, err := storm.Open("my.db")
	if err != nil {
		return nil, err
	}
	defer db.Close()
	var users []User
	err = db.All(&users)
	if err != nil {
		return nil, err
	}
	var protoUsers []*proto.User
	for _, u := range users {
		protoUsers = append(protoUsers, UserToProto(&u))
	}
	return protoUsers, nil
}

func UpdateCurrentUser(name string) error {
	db, err := storm.Open("my.db")
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
	db, err := storm.Open("my.db")
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

func ReadUser(name string) (*proto.User, error) {
	db, err := storm.Open("my.db")
	if err != nil {
		return nil, err
	}
	defer db.Close()
	user := &proto.User{}
	err = db.One("Title", name, &user)
	if err != nil {
		return nil, err
	}
	return user, nil
}
