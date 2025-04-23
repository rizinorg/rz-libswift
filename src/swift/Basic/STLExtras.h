// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#ifndef RZ_LIBSWIFT_STLEXTRAS_H
#define RZ_LIBSWIFT_STLEXTRAS_H

#include "llvm/ADT/StringRef.h"

namespace llvm {
template <typename ForwardIterator, typename UnaryFunctor,
	typename NullaryFunctor,
	typename = typename std::enable_if<
		!std::is_constructible<StringRef, UnaryFunctor>::value &&
		!std::is_constructible<StringRef, NullaryFunctor>::value>::type>
inline void interleave(ForwardIterator begin, ForwardIterator end,
	UnaryFunctor each_fn, NullaryFunctor between_fn) {
	if (begin == end) {
		return;
	}
	each_fn(*begin);
	++begin;
	for (; begin != end; ++begin) {
		between_fn();
		each_fn(*begin);
	}
}
} // namespace llvm

#endif /* RZ_LIBSWIFT_STLEXTRAS_H */