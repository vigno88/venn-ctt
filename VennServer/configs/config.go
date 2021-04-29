package config

import (
	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
	"github.com/vigno88/Venn/VennServer/pkg/metrics"
	recipe "github.com/vigno88/Venn/VennServer/pkg/recipes"
)

func GetMetricName(smallName string) string {
	for _, v := range GetDefaultConfig().Metrics {
		if v.SmallName == smallName {
			return v.Name
		}
	}
	return ""
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
		Destination: proto.Setting_MICROCONTROLLER,
		Value:       20,
		Max:         95,
		Min:         20,
		Name:        "Temperature",
		Info:        "This slider controls the temperature of the water.",
		SmallName:   "t",
		Target:      &proto.Target{Name: "Temperature 1", Uncertainty: 2},
	}

	generalS2 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Speed Masseur 1",
		SmallName:   "sm1",
		Info:        "This slider controls the speed of first module's masseur.",
	}

	generalS3 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Travel Masseur 1",
		SmallName:   "tm1",
		Info:        "This slider controls the travel distance of first module's masseur.",
	}
	generalS4 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Masseur 1",
		SmallName:   "pm1",
		Info:        "This slider records the pression of first module's masseur.",
	}
	generalS5 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Speed Masseur 2",
		SmallName:   "sm2",
		Info:        "This slider controls the speed of second module's masseur.",
	}
	generalS6 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Travel Masseur 2",
		SmallName:   "tm2",
		Info:        "This slider controls the travel distance of second module's masseur.",
	}
	generalS7 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Masseur 2",
		SmallName:   "pm2",
		Info:        "This slider records the pression of second module's masseur.",
	}
	generalS8 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Speed Masseur 3",
		SmallName:   "sm3",
		Info:        "This slider controls the speed of third module's masseur.",
	}
	generalS9 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Travel Masseur 3",
		SmallName:   "tm3",
		Info:        "This slider controls the travel distance of third module's masseur.",
	}
	generalS10 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Masseur 3",
		SmallName:   "pm3",
		Info:        "This slider records the pression of third module's masseur.",
	}
	generalS11 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Speed Traction 1",
		SmallName:   "st1",
		Info:        "This slider controls the speed of first module's traction.",
	}
	generalS12 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Traction 1",
		SmallName:   "pt1",
		Info:        "This slider records the pression of first module's traction.",
	}
	generalS13 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Speed Traction 2",
		SmallName:   "st2",
		Info:        "This slider controls the speed of second module's traction.",
	}
	generalS14 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Traction 2",
		SmallName:   "pt2",
		Info:        "This slider records the pression of second module's traction.",
	}
	generalS15 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Speed Traction 3",
		SmallName:   "st3",
		Info:        "This slider controls the speed of third module's traction.",
	}
	generalS16 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Traction 3",
		SmallName:   "pt3",
		Info:        "This slider records the pression of third module's traction.",
	}

	c1 := &proto.Choice{
		Name: "One",
	}
	c2 := &proto.Choice{
		Name: "Two",
	}
	c3 := &proto.Choice{
		Name: "Three",
	}

	return &ReadableConfig{
		Recipe: recipe.Recipe{
			UUID: "",
			Name: "Recipe 1",
			Info: "This is the default recipe from config.",
			Selectors: []*proto.Selector{
				{
					Name:           "Active Module Count",
					SelectedChoice: c3,
					PossibleChoices: []*proto.Choice{
						c1, c2, c3,
					},
				},
			},
			Sliders: []*proto.Setting{
				generalS1,
				generalS2,
				generalS3,
				generalS4,
				generalS5,
				generalS6,
				generalS7,
				generalS8,
				generalS9,
				generalS10,
				generalS11,
				generalS12,
				generalS13,
				generalS14,
				generalS15,
				generalS16,
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
