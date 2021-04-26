// +build production

package motors

import (
	"log"
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
}

func Init() error {
	motors.init()
	// If there is no motor connected, retry
	if motors.Count == 0 {
		motors.init()
	}
	motors.setVelNode(0, 4100)
	motors.setAccelNode(0, 12000)
	motors.setVelNode(2, 4100)
	motors.setAccelNode(2, 12000)
	motors.setVelNode(4, 4100)
	motors.setAccelNode(4, 12000)
	log.Printf("There are %d nodes connected\n", motors.Count)
	motors.isCycling = false
	motors.isHoming = false
	// Gather the settings of each node

	return nil
}

func Run() {
	// motors.startMoveVelNode(1, 400)
	travel1 := 4000
	for {
		if motors.isCycling {
			if motors.isMoveDoneNode(0) {
				travel1 = -travel1
				motors.startMovePosNode(0, travel1)
				motors.startMovePosNode(2, -travel1)
				motors.startMovePosNode(4, travel1)
			}
		}
	}
}

func StartCycle() error {
	motors.startMoveVelNode(1, 400)
	motors.startMoveVelNode(3, 400)
	motors.startMoveVelNode(5, 400)
	motors.startMovePosNode(0, 4000)
	motors.startMovePosNode(2, -4000)
	motors.startMovePosNode(4, 4000)
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

func SetVelocity(index int, vel int) {
	motors.nodes[index].Velocity = vel
}

func SetAcceleration(index int, accel int) {
	motors.nodes[index].Acceleration = accel
}

func IsHoming() bool {
	return motors.isHoming
}

func IsCycling() bool {
	return motors.isCycling
}
