#include <cstdint>
#include <iostream>

#include "Enhedron/Util/Optimization.h"

namespace Enhedron { namespace Examples { namespace Impl {
    using std::cout;
    using std::size_t;

    using Util::Restrict;

    void add(double* source, double* destination, size_t size);
    void addAligned(double* source, double* destination, size_t size);
    void addStrict(Restrict<double*> source, Restrict<double*> destination, size_t size);

    void main() {
        static constexpr const size_t size = 256;

        double source[size];
        double destination[size];

        for (size_t index = 0; index < size; ++index) {
            source[index] = index;
            destination[index] = index;
        }

        add(source, destination, size);
        addAligned(source, destination, size);
        addStrict(source, destination, size);

        for (size_t index = 0; index < size; ++index) {
            cout << destination[index] << '\n';
        }
    }
}

using Impl::main;
}}

int main() {
    Enhedron::Examples::main();
    
    return 0;
}

