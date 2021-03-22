package configuration

import (
	"context"
	"io/ioutil"
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/util"
	"gopkg.in/yaml.v2"
)

type Config struct {
	DefaultRecipe []struct {
		Setting struct {
			Type      string  `yaml:"type"`
			Value     float64 `yaml:"value"`
			Max       float64 `yaml:"max"`
			Min       float64 `yaml:"min"`
			Name      string  `yaml:"name"`
			Info      string  `yaml:"info"`
			SmallName string  `yaml:"smallName"`
			GoalName  string  `yaml:"goalName"`
		} `yaml:"setting"`
	} `yaml:"defaultRecipe"`
	Metrics []struct {
		Metric struct {
			Unit      string  `yaml:"unit"`
			Goal      float64 `yaml:"goal"`
			Type      string  `yaml:"type"`
			Name      string  `yaml:"name"`
			Info      string  `yaml:"info"`
			SmallName string  `yaml:"smallName"`
			HasGoal   bool    `yaml:"hasGoal"`
		} `yaml:"metric"`
	} `yaml:"metrics"`
}

// metricsNamesMap is a map indexed by small names and returns the long name
var metricsNamesMap map[string]string

// settingsNamesMap is a map indexed by long names and returns the small name
var settingsNamesMap map[string]string
var config *Config

func main() {
	log.Printf("Updating config in DB")
	// Get config from file
	data, err := ioutil.ReadFile(path)
	print(string(data))
	if err != nil {
		return err
	}
	config = &Config{}
	err = yaml.Unmarshal(data, config)
	if err != nil {
		return err
	}
	GetDefaultRecipe(ctx)
	getNamesMap(ctx)
	return nil
}

func GetDefaultRecipe(ctx context.Context) *proto.Recipe {
	// Get the settings from the config
	var settings []*proto.Setting
	for _, setting := range config.DefaultRecipe {
		s := &proto.Setting{
			Info:     setting.Setting.Info,
			Max:      setting.Setting.Max,
			Min:      setting.Setting.Min,
			Name:     setting.Setting.Name,
			Value:    setting.Setting.Value,
			GoalName: setting.Setting.GoalName,
		}
		settings = append(settings, s)
	}
	return &proto.Recipe{Uuid: util.GetNewUUID(ctx), Settings: settings}
}

func getNamesMap(ctx context.Context) {
	// Fill metric name map
	metricsNamesMap = make(map[string]string)
	for _, m := range config.Metrics {
		metricsNamesMap[m.Metric.SmallName] = m.Metric.Name
	}
	// Fill settings name map
	settingsNamesMap = make(map[string]string)
	for _, s := range config.DefaultRecipe {
		settingsNamesMap[s.Setting.Name] = s.Setting.SmallName
	}
}

func GetConfig(ctx context.Context) *proto.Configuration {
	pC := &proto.Configuration{}
	// Get the metrics config
	for _, m := range config.Metrics {
		m := &proto.MetricConfig{
			Goal:    float32(m.Metric.Goal),
			Info:    m.Metric.Info,
			Name:    m.Metric.Name,
			Type:    m.Metric.Type,
			Unit:    m.Metric.Unit,
			HasGoal: m.Metric.HasGoal,
		}
		pC.MetricsConfig = append(pC.MetricsConfig, m)
	}
	return pC
}

// setConfig updates the metrics config received from the UI
// more particulary the goal value
func SetMetricsConfig(c *proto.Configuration) {
	for _, m := range c.MetricsConfig {
		for i, mC := range config.Metrics {
			if mC.Metric.Name == m.Name {
				config.Metrics[i].Metric.Goal = float64(m.Goal)
			}
		}
	}
}

// func GetDefaultRecipe(ctx context.Context) *proto.Recipe {
// 	return &defaultRecipe
// }

func GetNameMetric(smallName string) string {
	return metricsNamesMap[smallName]
}

func GetSmallNameSetting(name string) string {
	return settingsNamesMap[name]
}

func GetGoal(name string) float64 {
	for _, mC := range config.Metrics {
		if mC.Metric.Name == name {
			return mC.Metric.Goal
		}
	}
	return 0
}
