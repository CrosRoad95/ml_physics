#include <algorithm>
#include <list>
#include <map>
#include <set>
#include <string>
#include <string_view>
#include <sstream>
#include <vector>
#include <cstdio>
#include <cstring>
#include <variant>
#include <optional>
#include <mutex>
#include <cassert>

typedef unsigned int uint;

enum class ePhysicsElementType
{
    Unknown,
    WorldElement,
    RigidBody,
    StaticCollision,

    // Shapes
    Shape,
    ConvexShape,
    BoxShape,
};

// Remove first occurrence of item from itemList
template <class T>
void ListRemoveFirst(std::vector<T>& itemList, const T& item)
{
    typename std::vector<T>::iterator it = itemList.begin();
    for (; it != itemList.end(); ++it)
        if (item == *it)
        {
            itemList.erase(it);
            break;
        }
}

const char* EnumToString(ePhysicsElementType)
{
    return "...";
}

class CLuaPhysicsRigidBody;
class CBulletPhysics;

class CGame
{
public:
    CGame(CBulletPhysics* pPhysics)
    {
        m_pPhysics = pPhysics;
    }

    CBulletPhysics* GetPhysics() const
    {
        return m_pPhysics;
    }
private:
    CBulletPhysics* m_pPhysics;
};

extern CGame* g_pGame;
//CGame* g_pGame;

#include "SString.h"
#include "SharedUtil.Time.h"
#include "SharedUtil.Misc.h"
#include "CVector.h"

inline float DistanceBetweenPoints3D(const CVector& vecPosition1, const CVector& vecPosition2)
{
    float fDistanceX = vecPosition2.fX - vecPosition1.fX;
    float fDistanceY = vecPosition2.fY - vecPosition1.fY;
    float fDistanceZ = vecPosition2.fZ - vecPosition1.fZ;

    return sqrt(fDistanceX * fDistanceX + fDistanceY * fDistanceY + fDistanceZ * fDistanceZ);
}

#include "CIdArray.h"
#include "CBulletPhysicsCommon.h"
#include "CBulletPhysics.h"
