package metric_script

import (
	config "github.com/vigno88/Venn/VennServer/configs"
	"github.com/vigno88/Venn/VennServer/pkg/metrics"
)

func main() {
	c := config.GetDefaultConfig()
	// Add all the metrics from the config in the metric store
	for _, v := range c.Metrics {
		metrics.Create(
			&metrics.Metric{
				Name:      v.Name,
				Unit:      v.Unit,
				Target:    v.Target,
				HasTarget: v.HasTarget,
				Type:      v.Type,
				Info:      v.Info,
				Value:     v.Value,
			},
		)
	}
}
