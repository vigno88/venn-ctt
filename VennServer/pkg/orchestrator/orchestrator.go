// +build production

package orchestrator

import (
	"context"
	"log"
	"os"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
	metrics "github.com/vigno88/Venn/VennServer/pkg/metrics"
	motors "github.com/vigno88/Venn/VennServer/pkg/motors"
	recipes "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/serial"
	"github.com/vigno88/Venn/VennServer/pkg/util"
	"github.com/vigno88/Venn/VennServer/pkg/wifi"
)

func Run(ctx context.Context, c chan *proto.MetricUpdates) {
	// Verify validity software
	// err := validate(util.PathKey)
	// if err != nil {
	// 	log.Fatalf(err.Error())
	// }
	// Initialize all the modules
	err := authentifaction.Init(ctx, util.PathAuth)
	handle(err)
	err = serial.Init(ctx, c)
	handle(err)
	err = metrics.Init(ctx, util.PathMetric)
	handle(err)
	err = wifi.Init(ctx, util.PathWifi)
	handle(err)
	err = motors.Init()
	handle(err)
	exit := make(chan string)
	go serial.Run(ctx, exit)
	go wifi.Run()
	go motors.Run()
	err = recipes.Init(ctx, util.PathRecipe)
	handle(err)
	log.Printf("Orchestrator is running..\n")
	for {
		select {
		case <-exit:
			os.Exit(0)
		}
	}
}

func handle(err error) {
	if err != nil {
		log.Printf("%v", err)
		os.Exit(0)
	}
}
