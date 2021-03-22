// +build mock

package orchestrator

import (
	"context"
	"log"
	"os"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	authentifaction "github.com/vigno88/Venn/VennServer/pkg/authentification"
	configuration "github.com/vigno88/Venn/VennServer/pkg/configuration"
	metrics "github.com/vigno88/Venn/VennServer/pkg/metrics"
	recipes "github.com/vigno88/Venn/VennServer/pkg/recipes"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func Run(ctx context.Context, c chan *proto.Metric) {
	// Initialize all the module
	err := authentifaction.Init(ctx, util.PathAuth)
	handle(err)
	err = configuration.Init(ctx, util.PathConfig)
	handle(err)
	// err = serial.Init(ctx, c)
	// handle(err)
	err = metrics.Init(ctx, util.PathMetric)
	handle(err)
	exit := make(chan string)
	// go serial.Run(ctx, exit)
	err = recipes.Init(ctx, util.PathRecipe)
	handle(err)
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
