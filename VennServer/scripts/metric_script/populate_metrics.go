package main

import (
	"context"
	"log"

	config "github.com/vigno88/Venn/VennServer/configs"
	"github.com/vigno88/Venn/VennServer/pkg/metrics"
	"github.com/vigno88/Venn/VennServer/pkg/util"
)

func main() {
	err := metrics.Init(context.Background(), util.PathMetric)
	if err != nil {
		log.Printf("Error while init metrics store: %s\n", err.Error())
	}
	c := config.GetDefaultConfig()
	// Add all the metrics from the config in the metric store
	for _, v := range c.Metrics {
		err := metrics.Create(&v)
		if err != nil {
			log.Fatalf("Error while adding metric: %s\n", err.Error())
		}

	}
	log.Println("Default metrics setup done")
}
