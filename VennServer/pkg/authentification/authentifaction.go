package authentifaction

import (
	"context"
	"fmt"
	"log"

	bolt "go.etcd.io/bbolt"
)

var pathDB string
var bucketName string

func Init(ctx context.Context, path string) error {
	// home, err := os.UserHomeDir()
	// if err != nil {
	// 	log.Printf("Error wen getting home path: %v", err)
	// }
	// pathDB = home + "/badger/auth.db"
	pathDB = path
	bucketName = "main"
	log.Printf("Initiating authentifaction store at %s", pathDB)
	db, err := bolt.Open(pathDB, 0600, nil)
	if err != nil {
		return err
	}
	err = db.Update(func(tx *bolt.Tx) error {
		_, err := tx.CreateBucketIfNotExists([]byte(bucketName))
		return err
	})
	db.Close()
	populate(ctx)
	return nil
}

// We have only two user for now so we populate the entries on init
func populate(ctx context.Context) error {
	db, err := bolt.Open(pathDB, 0600, nil)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Update(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(bucketName))
		err := b.Put([]byte("admin"), []byte("admin"))
		if err != nil {
			return err
		}
		err = b.Put([]byte("fab"), []byte("uneed"))
		return err
	})
	if err != nil {
		log.Printf("Error while populating authentifaction store: %v", err)
	}
	return err
}

func Verify(ctx context.Context, username string, password string) (bool, error) {
	var value []byte
	db, err := bolt.Open(pathDB, 0644, nil)
	if err != nil {
		return false, err
	}
	defer db.Close()
	err = db.View(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(bucketName))
		value = b.Get([]byte(username))
		if b == nil {
			return fmt.Errorf("Couldnt get %s key value", username)
		}
		return nil
	})
	if err != nil {
		return false, err
	}
	if password != string(value) {
		return false, nil
	}
	return true, nil
}
