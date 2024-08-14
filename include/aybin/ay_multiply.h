#pragma once

#if defined(_WIN32) && !defined(__GNUC__) && !defined(AYBIN_IS_STATIC)
    #define AY_BIN_API __declspec(dllimport)
#else
    #define AY_BIN_API
#endif

namespace iin {
AY_BIN_API int  ayMultiply(int, int);
AY_BIN_API bool ayMultiply(bool, bool);
}
