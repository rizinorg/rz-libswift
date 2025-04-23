// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#ifndef RZ_LIBSWIFT_OPTIONAL_H
#define RZ_LIBSWIFT_OPTIONAL_H

#include <cassert>
#include <functional>
#include <cstring>
#include <string>
#include <climits>

namespace llvm {

enum class NoneType { None = 1 };
const NoneType None = NoneType::None;

template <typename T>
class Optional {
      private:
	bool _has_value;
	T _value;

      public:
	constexpr Optional()
	    : _has_value(false) {}
	constexpr Optional(NoneType)
	    : _has_value(false) {}
	constexpr Optional(T v)
	    : _has_value(true), _value(v) {}

	constexpr const T &getValue() const {
		return _value;
	}

	constexpr const T &value() const {
		return _value;
	}

	constexpr T *getPointer() const {
		return &_value;
	}

	constexpr bool hasValue() const {
		return _has_value;
	}

	constexpr bool has_value() const {
		return _has_value;
	}

	constexpr const T &operator*() const {
		return getValue();
	}

	constexpr const T *operator->() const {
		return getPointer();
	}
};

}; // namespace llvm

#endif /* RZ_LIBSWIFT_OPTIONAL_H */