package orchestrator

import (
	"encoding/base64"
	"fmt"
	"io/ioutil"
	"log"
	"net"
	"reflect"
	"strings"
)

func validate(path string) error {
	// read file key
	content, err := ioutil.ReadFile(path)
	if err != nil {
		log.Fatal(err)
	}

	bytes, _ := base64.StdEncoding.DecodeString(string(content))
	keys := strings.Split(string(bytes), "\n")

	ifas, err := net.Interfaces()
	if err != nil {
		log.Fatal(err)
	}
	var as []string
	for _, ifa := range ifas {
		a := ifa.HardwareAddr.String()
		if a != "" {
			as = append(as, a)
		}
	}

	equal := reflect.DeepEqual(keys, as)
	if equal {
		return nil
	}
	return fmt.Errorf("Invalid key\n")
}
