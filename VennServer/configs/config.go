package config

import (
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/metrics"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
)

var SettingsSmallNames = map[string]string{
	"Temperature": "1",
	"Vitesse":     "2",
	"Temps":       "3",
}

var SettingLongName = map[string]string{
	"1": "Temperature",
	"2": "Vitesse",
	"3": "Temps",
}

func GetTarget(name string) float32 {
	for _, v := range GetDefaultConfig().Metrics {
		if v.Name == name {
			return v.Target
		}
	}
	return 0
}

type ReadableConfig struct {
	Recipe  recipe.Recipe
	Metrics []metrics.Metric
}

// This function is to be a human readable config
func GetDefaultConfig() *ReadableConfig {
	generalS1 := &proto.Setting{
		Type:   "slider",
		Value:  0,
		Max:    100,
		Min:    0,
		Name:   "Temperature",
		Info:   "Ce slider controle la temperature de l'air en pourcentage ",
		Target: &proto.Target{Name: "Temperature 1"},
	}

	generalS2 := &proto.Setting{
		Type:  "slider",
		Value: 0,
		Max:   100,
		Min:   0,
		Name:  "Vitesse",
		Info:  "Ce slider controle la vitesse de rotation du tonneau.",
	}

	generalS3 := &proto.Setting{
		Type:  "slider",
		Value: 1,
		Max:   600,
		Min:   30,
		Name:  "Temps",
		Info:  "Ce slider controle le temps de rotation du tonnean en seconde.",
	}

	c1 := &proto.Choice{
		Name: "Choice 1",
	}
	c2 := &proto.Choice{
		Name: "Choice 2",
	}
	c3 := &proto.Choice{
		Name: "Choice 3",
	}

	return &ReadableConfig{
		Recipe: recipe.Recipe{
			UUID: "",
			Name: "Recipe 1",
			Info: "This is the default recipe from config.",
			Selectors: map[string]*proto.Selector{
				"Selector 1": {
					Name:           "Selector 1",
					SelectedChoice: c1,
					PossibleChoices: []*proto.Choice{
						c1, c2, c3,
					},
				},
			},
			Sliders: map[string]*proto.Setting{
				"Temperature": generalS1,
				"Vitesse":     generalS2,
				"Temps":       generalS3,
			},
		},
		Metrics: []metrics.Metric{
			{
				Name:      "Temperature 1",
				Unit:      "°c",
				Type:      "temperature",
				Info:      "La temperature 1",
				HasTarget: true,
				Target:    20,
				Value:     0,
			},
			{
				Name:      "Humidity 1",
				Unit:      "%",
				Type:      "humidity",
				Info:      "L'humidite 1",
				HasTarget: false,
				Value:     0,
			},
			{
				Name:      "Temperature 2",
				Unit:      "°c",
				Type:      "temperature",
				Info:      "La temperature 2",
				HasTarget: false,
				Value:     0,
			},
		},
	}
}
