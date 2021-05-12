typedef void CMotors;

#ifdef __cplusplus
extern "C" {
#endif

void Initialize();
int NodeCount();

void HomeNodes();
void StartMovePosNode(int indexNode, int numSteps, int targetIsAbsolute);
void StartMoveVelNode(int indexNode, int velocity);
int IsMoveDoneNode(int indexNode);
int ReadPosNode(int indexNode); 
int ReadPosCommandedNode(int indexNode);
int ReadVelNode(int indexNode);
		
void SetAccelNode(int indexNode, int accel);
void SetVelNode(int indexNode, int vel);

void StopNodeHard(int indexNode);
void StopNodeDecel(int indexNode);
void StopNodeClear(int indexNode);

#ifdef __cplusplus
}
#endif
