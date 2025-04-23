// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#ifndef RZ_LIBSWIFT_STRINGSWITCH_H
#define RZ_LIBSWIFT_STRINGSWITCH_H

#include "llvm/ADT/StringRef.h"

namespace llvm {

template <typename T, typename R = T>
class StringSwitch {
	const StringRef to_compare;
	T result;

      public:
	StringSwitch(StringRef value)
	    : to_compare(value) {}
	~StringSwitch() = default;

	StringSwitch &Case(const char literal[], T case_value) {
		if (!result && to_compare == literal) {
			result = case_value;
		}
		return *this;
	}

	R Default(T default_value) {
		if (result) {
			return result;
		}
		return default_value;
	}

	operator R() {
		return result;
	}
};

} // namespace llvm

#endif /* RZ_LIBSWIFT_STRINGSWITCH_H */