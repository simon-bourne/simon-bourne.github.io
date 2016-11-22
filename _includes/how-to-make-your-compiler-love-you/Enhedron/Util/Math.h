// Copyright 2014 Enhedron Ltd

#pragma once

#include <type_traits>

namespace Enhedron { namespace Util {
namespace Impl {
    using std::is_integral;

    template<typename Numerator, typename Denominator>
    constexpr bool isDivisible(Numerator numerator, Denominator denominator) {
        static_assert(is_integral<Numerator>::value, "Numerator must be an integral type");
        static_assert(is_integral<Denominator>::value, "Denominator must be an integral type");

        return denominator * (numerator / denominator) == numerator;
    }
}

using Impl::isDivisible;
}}

