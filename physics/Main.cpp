#include "StdInc.h"

extern "C" __declspec(dllexport) CBulletPhysicsBase* Run();

CBulletPhysicsBase* Run()
{
    CBulletPhysics* physics = new CBulletPhysics();
    return physics;
}