package motors

// #cgo CFLAGS: -I./include
// #cgo LDFLAGS: ./include/libLibMotors.a
// #cgo LDFLAGS: -lstdc++
// #cgo LDFLAGS: -lm
// #cgo LDFLAGS: -ldl
// #include <motors.h>
import "C"
import "fmt"

type CMotors struct {
	Count int
}

// Motors is used as a singleton that represent the clear path motors
var Motors CMotors

// Init cr
func (m *CMotors) Init() {
	C.Initialize()
	m.Count = int(C.NodeCount())
}

func (m *CMotors) HomeNode(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.HomeNode(C.int(i))
	return nil
}

func (m *CMotors) StartMoveNode(i int, numSteps int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StartMoveNode(C.int(i), C.int(numSteps))
	return nil
}

func (m *CMotors) IsMoveDoneNode(i int) (bool, error) {
	if i < 0 || i >= m.Count {
		return false, fmt.Errorf("Invalid node index: %d", i)
	}
	if int(C.IsMoveDoneNode(C.int(i))) == 1 {
		return true, nil
	}
	return false, nil
}

func (m *CMotors) ReadPosNode(i int) (int, error) {
	if i < 0 || i >= m.Count {
		return 0, fmt.Errorf("Invalid node index: %d", i)
	}
	return int(C.ReadPosNode(C.int(i))), nil
}

func (m *CMotors) ReadPosCommandedNode(i int) (int, error) {
	if i < 0 || i >= m.Count {
		return 0, fmt.Errorf("Invalid node index: %d", i)
	}
	return int(C.ReadPosCommandedNode(C.int(i))), nil
}

func (m *CMotors) ReadVelNode(i int) (int, error) {
	if i < 0 || i >= m.Count {
		return 0, fmt.Errorf("Invalid node index: %d", i)
	}
	return int(C.ReadVelNode(C.int(i))), nil
}

func (m *CMotors) SetAccelNode(i int, accel int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.SetAccelNode(C.int(i), C.int(accel))
	return nil
}

func (m *CMotors) SetVelNode(i int, vel int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.SetVelNode(C.int(i), C.int(vel))
	return nil
}

func (m *CMotors) BackAndForthSequence(i int, travelLength int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.BackAndForthSequence(C.int(i), C.int(travelLength))
	return nil
}

func (m *CMotors) StopNodeHard(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StopNodeHard(C.int(i))
	return nil
}

func (m *CMotors) StopNodeDecel(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StopNodeDecel(C.int(i))
	return nil
}

func (m *CMotors) StopNodeClear(i int) error {
	if i < 0 || i >= m.Count {
		return fmt.Errorf("Invalid node index: %d", i)
	}
	C.StopNodeClear(C.int(i))
	return nil
}
