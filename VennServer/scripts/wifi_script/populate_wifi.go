package main

import (
	"context"
	"log"

	"github.com/vigno88/Venn/VennServer/pkg/util"
	"github.com/vigno88/Venn/VennServer/pkg/wifi"
)

func main() {
	err := wifi.AddCredential(&wifi.Credential{
		SSID:     "Automatisation U-Need 2.4GHz",
		Password: "U-NeedWifi",
		// SSID:     "BELL873",
		// Password: "145129141F5E",
	}, util.PathWifi)
	if err != nil {
		log.Printf("Error %s\n", err.Error())
		panic(err)
	}
	err = wifi.Init(context.Background(), util.PathWifi)
	if err != nil {
		log.Printf("Error %s\n", err.Error())
		panic(err)
	}
	log.Println("Default network setup done")
}
