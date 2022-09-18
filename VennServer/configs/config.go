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
	temp := &proto.Setting{
		Destination: proto.Setting_MICROCONTROLLER,
		Value:       20,
		Max:         95,
		Min:         20,
		Name:        "Temperature",
		Info:        "This slider controls the temperature of the water.",
		SmallName:   "t",
	}
	sm1 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       200,
		Max:         1000,
		Min:         0,
		Name:        "Speed Masseur 1",
		SmallName:   "sm1",
		Info:        "This slider controls the speed in RPM of first module's masseur.",
	}

	// tm1 := &proto.Setting{
	// 	Destination: proto.Setting_MOTOR,
	// 	Value:       2000,
	// 	Max:         5000,
	// 	Min:         100,
	// 	Name:        "Travel Masseur 1",
	// 	SmallName:   "tm1",
	// 	Info:        "This slider controls the travel distance of first module's masseur.",
	// }
	// tm2 := &proto.Setting{
	// 	Destination: proto.Setting_MOTOR,
	// 	Value:       2000,
	// 	Max:         5000,
	// 	Min:         100,
	// 	Name:        "Travel Masseur 2",
	// 	SmallName:   "tm2",
	// 	Info:        "This slider controls the travel distance of second module's masseur.",
	// }
	// tm3 := &proto.Setting{
	// 	Destination: proto.Setting_MOTOR,
	// 	Value:       2000,
	// 	Max:         5000,
	// 	Min:         100,
	// 	Name:        "Travel Masseur 3",
	// 	SmallName:   "tm3",
	// 	Info:        "This slider controls the travel distance of third module's masseur.",
	// }
	dt1 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       10,
		Max:         200,
		Min:         5,
		Name:        "Divisor Traction 1",
		SmallName:   "dt1",
		Info:        "The speed of Traction 1 is the one of Masseur 1 divided by Divisor Traction 1",
	}
	dt2 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       10,
		Max:         200,
		Min:         5,
		Name:        "Divisor Traction 2",
		SmallName:   "dt2",
		Info:        "The speed of Traction 2 is the one of Masseur 2 divided by Divisor Traction 2",
	}
	dt3 := &proto.Setting{
		Destination: proto.Setting_MOTOR,
		Value:       10,
		Max:         200,
		Min:         5,
		Name:        "Divisor Traction 3",
		SmallName:   "dt3",
		Info:        "The speed of Traction 3 is the one of Masseur 3 divided by Divisor Traction 3",
	}
	pm1 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Masseur 1",
		SmallName:   "pm1",
		Info:        "This slider records the pression of first module's masseur.",
	}

	pm2 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Masseur 2",
		SmallName:   "pm2",
		Info:        "This slider records the pression of second module's masseur.",
	}
	pm3 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Masseur 3",
		SmallName:   "pm3",
		Info:        "This slider records the pression of third module's masseur.",
	}
	pt1 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Traction 1",
		SmallName:   "pt1",
		Info:        "This slider records the pression of first module's traction.",
	}

	pt2 := &proto.Setting{
		Destination: proto.Setting_NONE,
		Value:       0,
		Max:         100,
		Min:         0,
		Name:        "Pression Traction 2",
		SmallName:   "pt2",
		Info:        "This slider records the pression of second module's traction.",
	}
	pt3 := &proto.Setting{
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
			Name: "Default",
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
				temp,
				sm1,
				dt1,
				dt2,
				dt3,
				pm1,
				pm2,
				pm3,
				pt1,
				pt2,
				pt3,
			},
		},
		Metrics: []metrics.Metric{
			{
				Name:      "Water",
				Unit:      "°c",
				Type:      "Temperature",
				SmallName: "t",
				Info:      "La temperature de l'eau",
				HasTarget: false,
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
