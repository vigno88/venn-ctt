package wifi

import (
	"context"
	"fmt"
	"time"

	wifi "github.com/mark2b/wpa-connect"
)

func Connect(ctx context.Context, ssid string, password string) error {
	if conn, err := wifi.ConnectManager.Connect(ssid, password, time.Second*60); err == nil {
		fmt.Println("Connected", conn.NetInterface, conn.SSID, conn.IP4.String(),
			conn.IP6.String())
	} else {
		return err
	}
	return nil
}
