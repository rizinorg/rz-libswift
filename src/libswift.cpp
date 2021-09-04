// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <wargio@libero.it>
// SPDX-License-Identifier: LGPL-3.0-only

#include <rz_libswift.h>
#include "swift/Demangling/Demangle.h"

char *rz_libswift_demangle_line(const char* line) {
	std::string symbol(line);

	std::string demangled = swift::Demangle::demangleSymbolAsString(symbol);

	char *copy = strdup(demangled.c_str());
	return copy;
}