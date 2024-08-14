#include "aybin/ay_multiply.h"
#include <iostream>

int main()
{
#ifdef AYBIN_IS_STATIC
    std::cout << "aybin is static" << std::endl;
#endif
    std::cout << iin::ayMultiply(1, 2) << std::endl;
    std::cout << int(iin::ayMultiply(true, false)) << std::endl;
    return 0;
}

