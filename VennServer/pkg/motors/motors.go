// +build production

package motors

import (
	"log"

	proto "github.com/vigno88/Venn/VennServer/pkg/api/v1"
)

type CMotors struct {
	Count     int
	nodes     []NodeConfig
	isCycling bool
	isHoming  bool
}

type NodeConfig struct {
	Acceleration int
	Velocity     int
	Travel       int
}

func initNodeConfig() {
	motors.nodes = []NodeConfig{
		{
			Acceleration: 12000,
			Velocity:     4100,
			Travel:       0,
		},
		{
			Acceleration: 0,
			Velocity:     400,
			Travel:       0,
		},
		{
			Acceleration: 12000,
			Velocity:     4100,
			Travel:       0,
		},
		{
			Acceleration: 0,
			Velocity:     400,
			Travel:       0,
		},
		{
			Acceleration: 12000,
			Velocity:     4100,
			Travel:       0,
		},
		{
			Acceleration: 0,
			Velocity:     400,
			Travel:       0,
		},
	}
}

func Init() error {
	motors.init()
	// If there is no motor connected, retry
	if motors.Count == 0 {
		motors.init()
	}
	motors.setVelNode(0, motors.nodes[0].Velocity)
	motors.setAccelNode(0, motors.nodes[0].Acceleration)
	motors.setVelNode(2, motors.nodes[2].Velocity)
	motors.setAccelNode(2, motors.nodes[2].Acceleration)
	motors.setVelNode(4, motors.nodes[4].Velocity)
	motors.setAccelNode(4, motors.nodes[4].Acceleration)
	log.Printf("There are %d nodes connected\n", motors.Count)
	motors.isCycling = false
	motors.isHoming = false
	// Gather the settings of each node

	return nil
}

func Run() {
	inverseFactor := 1
	for {
		if motors.isCycling {
			if motors.isMoveDoneNode(0) {
				inverseFactor = -inverseFactor
				motors.startMovePosNode(0, inverseFactor*motors.nodes[0].Travel)
				motors.startMovePosNode(2, -inverseFactor*motors.nodes[2].Travel)
				motors.startMovePosNode(4, inverseFactor*motors.nodes[4].Travel)
			}
		}
	}
}

func StartCycle() error {
	motors.startMoveVelNode(1, motors.nodes[1].Velocity)
	motors.startMoveVelNode(3, motors.nodes[3].Velocity)
	motors.startMoveVelNode(5, motors.nodes[5].Velocity)
	motors.startMovePosNode(0, motors.nodes[0].Travel)
	motors.startMovePosNode(2, -motors.nodes[2].Travel)
	motors.startMovePosNode(4, motors.nodes[4].Travel)
	motors.isCycling = true
	return nil
}

func StopCycle() error {
	motors.stopNodeHard(0)
	motors.stopNodeHard(1)
	motors.stopNodeHard(2)
	motors.stopNodeHard(3)
	motors.stopNodeHard(4)
	motors.stopNodeHard(5)
	motors.isCycling = false
	return nil
}

func Home() error {
	motors.isHoming = true
	motors.homeNodes()
	motors.isHoming = false
	return nil
}

func ProcessNewSetting(s *proto.Setting, newValue int) {
	switch s.SmallName {
	case "sm1":
		// Update the velocity of the first masseur and send the new velocity to the engine
		motors.nodes[0].Velocity = newValue
		motors.setVelNode(0, motors.nodes[0].Velocity)
		break
	case "tm1":
		// Update the travel distance of the first masseur
		motors.nodes[0].Travel = newValue
		break
	case "sm2":
		// Update the velocity of the second masseur and send the new velocity to the engine
		motors.nodes[2].Velocity = newValue
		motors.setVelNode(2, motors.nodes[2].Velocity)
		break
	case "tm2":
		// Update the travel distance of the second masseur
		motors.nodes[2].Travel = newValue
		break
	case "sm3":
		// Update the velocity of the third masseur and send the new velocity to the engine
		motors.nodes[4].Velocity = newValue
		motors.setVelNode(4, motors.nodes[4].Velocity)
		break
	case "tm3":
		// Update the travel distance of the third masseur
		motors.nodes[4].Travel = newValue
		break
	case "st1":
		// Update the velocity of the first traction engine and send the new velocity to the engine
		motors.nodes[1].Velocity = newValue
		motors.setVelNode(1, motors.nodes[1].Velocity)
		break
	case "st2":
		// Update the velocity of the second traction engine and send the new velocity to the engine
		motors.nodes[3].Velocity = newValue
		motors.setVelNode(3, motors.nodes[3].Velocity)
		break
	case "st3":
		// Update the velocity of the third traction engine and send the new velocity to the engine
		motors.nodes[5].Velocity = newValue
		motors.setVelNode(5, motors.nodes[5].Velocity)
		break
	}
}

func IsHoming() bool {
	return motors.isHoming
}

func IsCycling() bool {
	return motors.isCycling
}
