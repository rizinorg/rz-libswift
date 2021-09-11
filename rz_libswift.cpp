// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <wargio@libero.it>
// SPDX-License-Identifier: LGPL-3.0-only

#include <rz_libswift.h>
#include <rz_util.h>
#include <rz_lib.h>
#include <rz_demangler.h>

static char *libswift_demangle_handler(const char *symbol) {
	if (RZ_STR_ISEMPTY(symbol)) {
		return NULL;
	}
	if (symbol[0] == '_' && symbol[1] == '_') {
		symbol++;
	}
	return rz_libswift_demangle_line(symbol);
}

static RzDemanglerPlugin libswift_demangler = {
	.language = "swift",
	.author = "Apple Inc.",
	.license = "Apache2",
	.demangle = &libswift_demangle_handler
};

#ifdef _MSC_VER
#define _RZ_API __declspec(dllexport)
#else
#define _RZ_API
#endif

_RZ_API RzLibStruct rizin_plugin = {
	.type = RZ_LIB_TYPE_DEMANGLER,
	.data = &libswift_demangler,
	.version = RZ_VERSION,
	.pkgname = "libswift"
};