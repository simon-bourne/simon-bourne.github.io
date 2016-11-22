// Copyright 2014 Enhedron Ltd

#include <cstdint>
#include <cassert>

#include "Enhedron/Util/Optimization.h"
#include "Enhedron/Util/Math.h"

namespace Enhedron { namespace Examples { namespace Impl {

using std::size_t;

using Util::Restrict;
using Util::assumeAligned;
using Util::isDivisible;

//! Add each element of source to destination
//! @param source Must not overlap with \p destination and must be aligned to 32 bytes.
//! @param destination Must not overlap with \p source and must be aligned to 32 bytes.
//! @param size Must be non zero and divisble by (32 / sizeof(double)
void addStrict(Restrict<double*> source, Restrict<double*> destination, size_t size) {
    static constexpr const size_t alignment = 32;
    static constexpr const size_t doublesPerAlignedBlock = alignment / sizeof(double);

    static_assert(
        isDivisible(alignment, sizeof(double)),
         "alignment must be divisible by sizeof(double)"
    );
    assert(
        isDivisible(size, doublesPerAlignedBlock) &&
        "size must be divisble by (32 / sizeof(double)"
    );

    auto destinationEnd = destination + size;
    
    assert(source >= destinationEnd || source + size <= destination);

    do {
        auto alignedSource = assumeAligned<double, alignment>(source);
        auto alignedDestination = assumeAligned<double, alignment>(destination);

        for (size_t index = 0; index < doublesPerAlignedBlock; ++index) {
            alignedDestination[index] += alignedSource[index];
        }

        destination += doublesPerAlignedBlock;
        source += doublesPerAlignedBlock;
    } while (destination != destinationEnd);
}

}}}

