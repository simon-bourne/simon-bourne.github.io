// Copyright 2014 Enhedron Ltd

#pragma once

#include <cstdint>

namespace Enhedron { namespace Util {
namespace Impl {
    using std::size_t;

    template<typename Value>
    using Restrict = Value __restrict;

    template<typename Value, size_t alignment, size_t offset = 0>
    Value* assumeAligned(Value* value) {
        return static_cast<Value*>(__builtin_assume_aligned(value, alignment, offset));
    }
}

using Impl::Restrict;
using Impl::assumeAligned;
}}

