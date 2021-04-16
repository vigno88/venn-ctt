// +build production

package motors

import "log"

type CMotors struct {
	Count int
	nodes []NodeConfig
}

type NodeConfig struct {
	Acceleration int
	Velocity     int
}

func Init() error {
	// motors.init()
	// If there is no motor connected, retry
	if motors.Count == 0 {
		motors.init()
	}
	log.Printf("There are %d nodes connected\n", motors.Count)

	// Gather the settings of each node

	return nil
}

func Run() {

}

func StartCycle() error {

	return nil
}

func StopCycle() error {
	return nil
}

func Home() error {
	return nil
}

func SetVelocity(index int, vel int) {
	motors.nodes[index].Velocity = vel
}

func SetAcceleration(index int, accel int) {
	motors.nodes[index].Acceleration = accel
}
