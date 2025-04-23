// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#include <rz_libswift.h>
#include <rz_util.h>
#include <rz_lib.h>
#include <rz_demangler.h>

#ifdef __cplusplus
extern "C" {
#endif

static char *libswift_demangle_handler(const char *symbol, RzDemanglerFlag flags) {
	if (RZ_STR_ISEMPTY(symbol)) {
		return NULL;
	}
	if (symbol[0] == '_' && symbol[1] == '_') {
		symbol++;
	}
	return rz_libswift_demangle_line(symbol);
}

static RzDemanglerPlugin libswift_demangler = {
	/* .language = */ "swift",
	/* .author = */ "Apple Inc.",
	/* .license = */ "Apache2",
	/* .demangle = */ &libswift_demangle_handler
};

#if defined(__GNUC__) && __GNUC__ >= 4
#define _RZ_API __attribute__((visibility("default")))
#elif defined(_MSC_VER)
#define _RZ_API __declspec(dllexport)
#else
#define _RZ_API
#endif

_RZ_API RzLibStruct rizin_plugin = {
	/* .type = */ RZ_LIB_TYPE_DEMANGLER,
	/* .data = */ &libswift_demangler,
	/* .version = */ RZ_VERSION,
	/* .free = */ nullptr,
};

#ifdef __cplusplus
}
#endif
