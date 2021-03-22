package metrics

import (
	"context"
	"fmt"
	"log"

	protobuf "github.com/golang/protobuf/proto"
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	bolt "go.etcd.io/bbolt"
)

var pathDB string
var bucketName string

// var metricsChan chan proto.Metric

// Init open the kv store at the specified path
func Init(ctx context.Context, path string) error {
	log.Printf("Initiating the metrics store at %s\n", pathDB)
	pathDB = path
	bucketName = "main"
	db, err := bolt.Open(pathDB, 0600, nil)
	if err != nil {
		return err
	}
	err = db.Update(func(tx *bolt.Tx) error {
		_, err := tx.CreateBucketIfNotExists([]byte(bucketName))
		return err
	})
	db.Close()
	return err
}

// Put put the metric into the kv store
func Put(ctx context.Context, metric *proto.Metric) error {
	bytes, err := protobuf.Marshal(metric)
	if err != nil {
		return err
	}

	db, err := bolt.Open(pathDB, 0600, nil)
	if err != nil {
		return err
	}
	defer db.Close()
	return db.Update(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(bucketName))
		err := b.Put([]byte(metric.GetName()), bytes)
		return err
	})
}

// Get takes the name of a metric and retrieve it from the kv store
func Get(ctx context.Context, name string) (*proto.Metric, error) {
	var value []byte
	db, err := bolt.Open(pathDB, 0600, nil)
	if err != nil {
		return nil, err
	}
	err = db.View(func(tx *bolt.Tx) error {
		b := tx.Bucket([]byte(bucketName))
		value = b.Get([]byte(name))
		if value == nil {
			return fmt.Errorf("Couldnt find the value of this key: %s", name)
		}
		return nil
	})
	metric := &proto.Metric{}
	if err != nil {
		return metric, err
	}
	err = protobuf.Unmarshal(value, metric)
	return metric, err
}

func GetAll(ctx context.Context) (*proto.Metrics, error) {
	// var metrics []*proto.Metric
	// err := db.View(func(txn *badger.Txn) error {
	// 	opts := badger.DefaultIteratorOptions
	// 	opts.PrefetchSize = 10
	// 	it := txn.NewIterator(opts)
	// 	defer it.Close()
	// 	for it.Rewind(); it.Valid(); it.Next() {
	// 		item := it.Item()
	// 		value, err := item.ValueCopy(nil)
	// 		if err != nil {
	// 			return err
	// 		}
	// 		metric := &proto.Metric{}
	// 		err = protobuf.Unmarshal(value, metric)
	// 		if err != nil {
	// 			return err
	// 		}
	// 		metrics = append(metrics, metric)
	// 	}
	// 	return nil
	// })
	// log.Printf("Retrieved all the metrics from the store\n")
	// return &proto.Metrics{Metrics: metrics}, err
	return nil, nil
}
