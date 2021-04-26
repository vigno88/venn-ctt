package wifi

import (
	"context"
	"fmt"
	"log"
	"time"

	"github.com/asdine/storm/v3"
	"github.com/go-ping/ping"
	wifi "github.com/mark2b/wpa-connect"
)

var pathDB string
var isConnected bool
var currentSSID string

type Credential struct {
	SSID     string `storm:"id"`
	Password string
}

func Init(ctx context.Context, path string) error {
	log.Printf("Initiating the wifi store at %s\n", path)
	pathDB = path
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	// Look if db contains an entry
	var credentials []Credential
	err = db.All(&credentials)
	if err != nil {
		return err
	}
	// Look if already connected to wifi
	connected, err := IsConnected()
	if connected {
		isConnected = true
		currentSSID = "Unknown"
		return nil
	}
	if len(credentials) != 0 {
		log.Printf("Trying to connect to: %s\n", credentials[0].SSID)
		_, err := wifi.ConnectManager.Connect(credentials[0].SSID, credentials[0].Password, time.Second*60)
		if err != nil {
			return err
		}
		isConnected = true
		currentSSID = credentials[0].SSID
		log.Printf("Connected to %s\n", currentSSID)
		return nil
	}
	log.Printf("Did not found any wifi\n")
	isConnected = false
	currentSSID = ``
	return nil
}

// Each 30 seconds check if wifi active
func Run() {
	for range time.Tick(time.Second * 30) {
		connected, err := IsConnected()
		if err != nil {
			panic(err)
		}
		if !connected {
			ConnectMostRecent()
		}
	}
}

func IsConnected() (bool, error) {
	pinger, err := ping.NewPinger("www.google.com")
	if err != nil {
		return false, nil
	}
	pinger.SetPrivileged(true)
	pinger.Count = 3
	err = pinger.Run() // Blocks until finished.
	if err != nil {
		return false, err
	}
	if pinger.Statistics().PacketsRecv == 3 {
		return true, nil
	}
	return false, nil
}

func Connect(ssid string, password string) error {
	if conn, err := wifi.ConnectManager.Connect(ssid, password, time.Second*60); err == nil {
		fmt.Println("Connected", conn.NetInterface, conn.SSID, conn.IP4.String(),
			conn.IP6.String())
		// Save the credentials in the database
		db, err := storm.Open(pathDB)
		if err != nil {
			return err
		}
		defer db.Close()
		// If the new SSID is different from the current one, replace by the new one
		if ssid != currentSSID {
			err = db.Delete("Credential", currentSSID)
			if err != nil {
				return err
			}
			err = db.Save(&Credential{SSID: ssid, Password: password})
			currentSSID = ssid
			return err
		}
		if err == storm.ErrAlreadyExists {
			err := db.Update(&Credential{SSID: ssid, Password: password})
			if err != nil {
				return err
			}
			currentSSID = ssid
		}
	} else {
		return err
	}
	return nil
}

func ConnectMostRecent() error {
	db, err := storm.Open(pathDB)
	if err != nil {
		return err
	}
	defer db.Close()
	// Look if db contains an entry
	var credentials []Credential
	err = db.All(&credentials)
	if err == storm.ErrNotFound || len(credentials) == 0 {
		return nil
	}
	if err != nil {
		return err
	}
	// Try connect to wifi if has one saved
	err = Connect(credentials[0].SSID, credentials[0].Password)
	if err != nil {
		isConnected = false
		currentSSID = ``
	}
	isConnected = true
	currentSSID = credentials[0].SSID
	return nil
}

func ReadStatus() (bool, string) {
	return isConnected, currentSSID
}

func ReadWifiList() ([]string, error) {
	var list []string
	wifi.ScanManager.NetInterface = `wlan0`
	if bssList, err := wifi.ScanManager.Scan(); err == nil {
		for _, bss := range bssList {
			list = append(list, bss.SSID)
		}
	} else {
		return nil, err
	}
	return list, nil
}

func AddCredential(c *Credential, path string) error {
	db, err := storm.Open(path)
	if err != nil {
		return err
	}
	defer db.Close()
	err = db.Save(c)
	return err
}
