// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#include <rz_libswift.h>
#include "swift/Demangling/Demangle.h"

std::string rz_libswift_demangle_line(std::string line) {
	try {
		return swift::Demangle::demangleSymbolAsString(line);
	} catch (const std::bad_exception& e) {
        return line;
    }
}

char *rz_libswift_demangle_line(const char *line) {
	std::string symbol(line);
	std::string demangled;

	try {
		demangled = swift::Demangle::demangleSymbolAsString(symbol);
	} catch (const std::bad_exception& e) {
        return nullptr;
    }

	if (demangled == symbol) {
		return nullptr;
	}

	char *copy = strdup(demangled.c_str());
	return copy;
}