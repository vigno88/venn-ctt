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
	Divisor      int
}

func initNodeConfig() {
	motors.nodes = []NodeConfig{
		{
			Acceleration: 1200,
			Velocity:     100,
			Travel:       6000,
		},
		{
			Acceleration: 0,
			Velocity:     400,
			Travel:       0,
			Divisor:      10,
		},
		{
			Acceleration: 12000,
			Velocity:     4100,
			Travel:       6000,
		},
		{
			Acceleration: 0,
			Velocity:     400,
			Travel:       0,
			Divisor:      10,
		},
		{
			Acceleration: 12000,
			Velocity:     4100,
			Travel:       6000,
		},
		{
			Acceleration: 0,
			Velocity:     400,
			Travel:       0,
			Divisor:      10,
		},
	}
}

func Init() error {
	initNodeConfig()
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
	return nil
}

func Run() {
	// inverseFactors := []int{1, 1, 1}
	// for {
	// 	if motors.isCycling {
	// 		if motors.isMoveDoneNode(0) {
	// 			inverseFactors[0] = -inverseFactors[0]
	// 			motors.startMovePosNode(0, inverseFactors[0]*motors.nodes[0].Travel, true)
	// 			motors.startMovePosNode(1, motors.nodes[1].Travel, false)
	// 		}
	// 		if motors.isMoveDoneNode(2) {
	// 			inverseFactors[1] = -inverseFactors[1]
	// 			motors.startMovePosNode(2, -inverseFactors[1]*motors.nodes[2].Travel, true)
	// 			motors.startMovePosNode(3, motors.nodes[3].Travel, false)

	// 		}
	// 		if motors.isMoveDoneNode(4) {
	// 			inverseFactors[2] = -inverseFactors[2]
	// 			motors.startMovePosNode(4, inverseFactors[2]*motors.nodes[4].Travel, true)
	// 			motors.startMovePosNode(5, motors.nodes[5].Travel, false)
	// 		}
	// 	}
	// }
}

func StartCycle() error {
	motors.startMoveVelNode(0, motors.nodes[0].Velocity)
	motors.startMoveVelNode(1, motors.nodes[1].Velocity)
	motors.startMoveVelNode(3, motors.nodes[3].Velocity)
	motors.startMoveVelNode(5, motors.nodes[5].Velocity)

	// motors.startMovePosNode(0, motors.nodes[0].Travel, true)
	// motors.startMovePosNode(1, motors.nodes[1].Travel/2, false)
	// motors.startMovePosNode(2, -motors.nodes[2].Travel, true)
	// motors.startMovePosNode(3, motors.nodes[3].Travel/2, false)
	// motors.startMovePosNode(4, motors.nodes[4].Travel, true)
	// motors.startMovePosNode(5, motors.nodes[5].Travel/2, false)
	motors.isCycling = true
	return nil
}

func StopCycle() error {
	motors.stopNodeHard(0)
	motors.stopNodeHard(1)
	// motors.stopNodeHard(2)
	motors.stopNodeHard(3)
	// motors.stopNodeHard(4)
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
		motors.nodes[0].Velocity = newValue
		if motors.isCycling {
			motors.startMoveVelNode(0, motors.nodes[0].Velocity)
		}
		break
	case "tm1":
		UpdateTravel(0, newValue)
		break
	case "tm2":
		UpdateTravel(2, newValue)
		break
	case "tm3":
		UpdateTravel(4, newValue)
		break
	case "dt1":
		UpdateDivisor(1, newValue)
		break
	case "dt2":
		UpdateDivisor(3, newValue)
		break
	case "dt3":
		UpdateDivisor(5, newValue)
		break
	}
}

func IsHoming() bool {
	return motors.isHoming
}

func IsCycling() bool {
	return motors.isCycling
}

func UpdateDivisor(indexMotor int, newValue int) {
	motors.nodes[indexMotor].Divisor = newValue
	// Set the new acceleration
	// newAccel := motors.nodes[indexMotor-1].Acceleration / newValue
	newAccel := motors.nodes[0].Acceleration / newValue
	motors.nodes[indexMotor].Acceleration = newAccel
	motors.setAccelNode(indexMotor, newAccel)

	// Set the new velocity
	// newVel := motors.nodes[indexMotor-1].Velocity / newValue
	newVel := motors.nodes[0].Velocity / newValue
	motors.nodes[indexMotor].Velocity = newVel
	motors.setVelNode(indexMotor, newVel)

	// Set the new travel; 2*[travel of previous motor] divided by 8 (servo resolution) divided by the divisor
	// motors.nodes[indexMotor].Travel = motors.nodes[indexMotor-1].Travel / (4 * newValue)
	motors.nodes[indexMotor].Travel = motors.nodes[0].Travel / (4 * newValue)
}

func UpdateTravel(indexMotor int, newValue int) {
	// Update the travel distance of the third masseur
	motors.nodes[indexMotor].Travel = newValue
	// Update the travel of the traction servo; [new travel masseur]*2 divided by 8(servo resolution) divided by the divisor
	motors.nodes[indexMotor+1].Travel = newValue / (4 * motors.nodes[indexMotor+1].Divisor)
}
