package motors

// #cgo CFLAGS: -I/home/nathan/dev/venn-ctt/VennServer/include
// #cgo LDFLAGS: /home/nathan/dev/venn-ctt/VennServer/include/libLibMotors.a
// #cgo LDFLAGS: -lstdc++
// #cgo LDFLAGS: -lm
// #cgo LDFLAGS: -ldl
// #include <motors.h>
import "C"
import "fmt"

// Motors is used as a singleton that represent the clear path motors
var motors CMotors

// Init cr
func (m *CMotors) init() {
	C.Initialize()
	m.Count = int(C.NodeCount())
}

func (m *CMotors) homeNode(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.HomeNode(C.int(i))
	return nil
}

func (m *CMotors) startMoveNode(i int, numSteps int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StartMoveNode(C.int(i), C.int(numSteps))
	return nil
}

func (m *CMotors) isMoveDoneNode(i int) (bool, error) {
	if i < 0 || i >= m.Count {
		return false, fmt.Errorf("Invalid node index: %d", i)
	}
	if int(C.IsMoveDoneNode(C.int(i))) == 1 {
		return true, nil
	}
	return false, nil
}

func (m *CMotors) readPosNode(i int) (int, error) {
	if i < 0 || i >= m.Count {
		return 0, fmt.Errorf("Invalid node index: %d", i)
	}
	return int(C.ReadPosNode(C.int(i))), nil
}

func (m *CMotors) readPosCommandedNode(i int) (int, error) {
	if i < 0 || i >= m.Count {
		return 0, fmt.Errorf("Invalid node index: %d", i)
	}
	return int(C.ReadPosCommandedNode(C.int(i))), nil
}

func (m *CMotors) readVelNode(i int) (int, error) {
	if i < 0 || i >= m.Count {
		return 0, fmt.Errorf("Invalid node index: %d", i)
	}
	return int(C.ReadVelNode(C.int(i))), nil
}

func (m *CMotors) setAccelNode(i int, accel int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.SetAccelNode(C.int(i), C.int(accel))
	return nil
}

func (m *CMotors) setVelNode(i int, vel int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.SetVelNode(C.int(i), C.int(vel))
	return nil
}

func (m *CMotors) backAndForthSequence(i int, travelLength int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.BackAndForthSequence(C.int(i), C.int(travelLength))
	return nil
}

func (m *CMotors) stopNodeHard(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StopNodeHard(C.int(i))
	return nil
}

func (m *CMotors) stopNodeDecel(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StopNodeDecel(C.int(i))
	return nil
}

func (m *CMotors) stopNodeClear(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StopNodeClear(C.int(i))
	return nil
}
