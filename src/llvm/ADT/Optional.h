// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <wargio@libero.it>
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
	bool has_value;
	T value;

public:
	constexpr Optional(): has_value(false) {}
	constexpr Optional(NoneType) {}
	constexpr Optional(T v): has_value(true), value(v) {}

	constexpr const T &getValue() const {
		return value;
	}

	constexpr T *getPointer() const {
		return &value;
	}

	constexpr bool hasValue() const {
		return has_value;
	}

	constexpr const T &operator*() const {
		return getValue();
	}

	constexpr const T *operator->() const {
		return getPointer();
	}
};

};

#endif /* RZ_LIBSWIFT_OPTIONAL_H */