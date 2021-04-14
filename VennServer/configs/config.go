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
				Name:      "Water",
				Unit:      "°c",
				Type:      "Temperature",
				Info:      "La temperature de l'eau",
				HasTarget: true,
				Target:    60,
				Value:     0,
			},
			{
				Name:      "Roller 1",
				Unit:      "RPM",
				Type:      "Speed",
				Info:      "Vitesse du rouleau 1",
				HasTarget: false,
				Value:     0,
			},
			{
				Name:      "Roller 2",
				Unit:      "RPM",
				Type:      "Speed",
				Info:      "Vitesse du rouleau 2",
				HasTarget: false,
				Value:     0,
			},
			{
				Name:      "Roller 3",
				Unit:      "RPM",
				Type:      "Speed",
				Info:      "Vitesse du rouleau 3",
				HasTarget: false,
				Value:     0,
			},
			{
				Name:      "Massage 1",
				Unit:      "C/s",
				Type:      "Speed",
				Info:      "Vitesse du massage en cycle (aller-retour) par seconde",
				HasTarget: false,
				Value:     0,
			},
			{
				Name:      "Massage 2",
				Unit:      "C/s",
				Type:      "Speed",
				Info:      "Vitesse du massage en cycle (aller-retour) par seconde",
				HasTarget: false,
				Value:     0,
			},
			{
				Name:      "Massage 3",
				Unit:      "C/s",
				Type:      "Speed",
				Info:      "Vitesse du massage en cycle (aller-retour) par seconde",
				HasTarget: false,
				Value:     0,
			},
		},
	}
}
