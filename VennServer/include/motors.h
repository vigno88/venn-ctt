#ifdef __cplusplus
extern "C" {
#endif

void Initialize();
int NodeCount();

void HomeNode(int indexNode);
void StartMoveNode(int indexNode, int numSteps);
int IsMoveDoneNode(int indexNode);
int ReadPosNode(int indexNode); 
int ReadPosCommandedNode(int indexNode);
int ReadVelNode(int indexNode);
		
void SetAccelNode(int indexNode, int accel);
void SetVelNode(int indexNode, int vel);

void BackAndForthSequence(int indexNode, int travelLength);
void StopNodeHard(int indexNode);
void StopNodeDecel(int indexNode);
void StopNodeClear(int indexNode);

#ifdef __cplusplus
}
#endif
