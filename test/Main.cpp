#include <iostream>
#include <windows.h>

#include "../physics/include/base/CPhysicsBase.h"

typedef CPhysicsBase*(*RunPhysics)();

int main()
{
    std::cout << "Hello World!\n";

    HINSTANCE hGetProcIDDLL = LoadLibrary("D:\\MTA SA\\ml_physics\\Build\\bin\\x86\\Debug\\physics_d.dll");

    if (!hGetProcIDDLL) {
        std::cout << "could not load the dynamic library" << std::endl;
        return EXIT_FAILURE;
    }

    // resolve function address here
    RunPhysics runPhysics = (RunPhysics)GetProcAddress(hGetProcIDDLL, "Run");
    if (!runPhysics) {
        std::cout << "could not locate the function" << std::endl;
        return EXIT_FAILURE;
    }

    CPhysicsBase* pPhysics = runPhysics();
    int a = 5;
}