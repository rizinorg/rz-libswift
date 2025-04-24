// SPDX-FileCopyrightText: 2021-2025 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021-2025 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#ifndef RZ_LIBSWIFT_STRINGREF_H
#define RZ_LIBSWIFT_STRINGREF_H

#include <cassert>
#include <functional>
#include <cstring>
#include <string>
#include <climits>
#include <algorithm>
#include "Optional.h"

#define LLVM_NODISCARD
#define llvm_unreachable(x) assert(false && (x))

namespace llvm {

class StringLiteral {
      private:
	const char *ptr;
	const size_t length;
	constexpr StringLiteral(const char *s, size_t l)
	    : ptr(s), length(l) {}

      public:
	template <size_t T>
	constexpr StringLiteral(const char (&s)[T])
	    : StringLiteral(s, T - 1) {}

	template <size_t T>
	static constexpr StringLiteral withInnerNUL(const char (&s)[T]) {
		return StringLiteral(s, T - 1);
	}

	constexpr const char *c_str() const {
		return ptr;
	}

	constexpr size_t size() const {
		return length;
	}
};

class StringRef : public std::string {
      public:
	StringRef()
	    : std::string() {}
	StringRef(const StringLiteral &s)
	    : std::string(s.c_str(), s.size()) {}
	StringRef(const std::string &s)
	    : std::string(s) {}
	StringRef(const std::string &s, std::size_t n)
	    : std::string(s, n) {}
	StringRef(const StringRef &s)
	    : std::string(s) {}
	StringRef(const StringRef &s, std::size_t n)
	    : std::string(s, n) {}
	StringRef(const char *s, std::size_t n)
	    : std::string(s, n) {}
	StringRef(const char *s)
	    : std::string(s) {}
	StringRef(std::size_t n, char c)
	    : std::string(n, c) {}

	inline bool operator==(const char rhs[]) {
		return std::string::compare(0, std::string::npos, (const char *)rhs) == 0;
	}

	inline bool operator!=(const char rhs[]) {
		return std::string::compare(0, std::string::npos, (const char *)rhs) == 0;
	}

	inline bool operator==(const StringLiteral &rhs) {
		return std::string::compare(0, std::string::npos, rhs.c_str()) == 0;
	}

	inline bool operator!=(const StringLiteral &rhs) {
		return std::string::compare(0, std::string::npos, rhs.c_str()) == 0;
	}

	StringRef &operator=(const StringRef &s) {
		std::string::assign(s);
		return *this;
	}

	StringRef take_back(size_t pos = 1) const {
		if (pos >= size()) {
			return *this;
		}
		return std::string::substr(size() - pos);
	}

	StringRef drop_while(std::function<bool(char)> exp, size_t beg = 0) {
		StringRef sf = std::string::substr(beg);
		while (!sf.empty()) {
			if (!exp(sf[0])) {
				return std::string::substr(size() - sf.size());
			}
			sf = sf.drop_front();
		}
		return std::string::substr(npos);
	}

	StringRef drop_back(size_t N = 1) const {
		return std::string::substr(0, size()-N);
	}

	StringRef slice(size_t beg, size_t end) const {
		beg = std::min(beg, std::string::length());
		end = std::min(std::max(beg, end), std::string::length());
		return StringRef(std::string::c_str() + beg, end - beg);
	}

	StringRef copy() const {
		if (empty()) {
			return StringRef();
		}
		return StringRef(str());
	}

	bool startswith(StringRef prefix) const {
		if (prefix.length() > length()) {
			return false;
		}
		return std::string::rfind(prefix, 0) == 0;
	}

	bool starts_with(StringRef prefix) const {
		return startswith(prefix);
	}

	bool endswith(StringRef suffix) const {
		if (suffix.length() > length()) {
			return false;
		}
		return std::string::compare(length() - suffix.length(), suffix.length(), suffix) == 0;
	}

	bool ends_with(StringRef suffix) const {
		return endswith(suffix);
	}

	StringRef substr(size_t beg, size_t end = std::string::npos) const {
		return std::string::substr(beg, end);
	}

	StringRef drop_front(size_t beg = 1) const {
		return std::string::substr(beg);
	}

	std::string str() const {
		return std::string::substr(0);
	}

	bool contains(StringRef s) const {
		return find(s) != std::string::npos;
	}

	bool contains(char c) const {
		return find(c) != std::string::npos;
	}

	bool consume_front(StringRef prefix) {
		if (!startswith(prefix)) {
			return false;
		}
		*this = drop_front(prefix.size());
		return true;
	}
};

}; // namespace llvm

#endif /* RZ_LIBSWIFT_STRINGREF_H */