#pragma once

#if defined(_WIN32) && !defined(__GNUC__)
    #define AY_BIN_API __declspec(dllexport)
#else
    #define AY_BIN_API
#endif

namespace iin {
AY_BIN_API int  ayMultiply(int, int);
AY_BIN_API bool ayMultiply(bool, bool);
}
