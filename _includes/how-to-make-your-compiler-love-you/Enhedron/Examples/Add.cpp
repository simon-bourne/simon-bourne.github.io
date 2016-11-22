// Copyright 2014 Enhedron Ltd

#include <cstdint>

namespace Enhedron { namespace Examples { namespace Impl {

using std::size_t;

//! Add each element of source to destination
void add(double* source, double* destination, size_t size) {
    for (size_t index = 0; index < size; index++) {
        destination[index] += source[index];
    }
}

}}}

