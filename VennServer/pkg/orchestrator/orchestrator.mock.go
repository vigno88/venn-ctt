// +build mock

package orchestrator

import (
	"context"
	"log"
	"os"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
	metrics "github.com/vigno88/Venn/VennServer/pkg/metrics"
	recipes "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func Run(ctx context.Context, c chan *proto.MetricUpdates) {
	err := authentifaction.Init(ctx, util.PathAuth)
	handle(err)
	// err = serial.Init(ctx, c)
	handle(err)
	err = metrics.Init(ctx, util.PathMetric)
	handle(err)
	// err = wifi.Init(ctx, util.PathWifi)
	handle(err)
	// err = motors.Init()
	handle(err)
	exit := make(chan string)
	// go serial.Run(ctx, exit)
	// go wifi.Run()
	// go motors.Run()
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
