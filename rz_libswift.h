// SPDX-FileCopyrightText: 2021 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2021 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#ifndef RZ_LIBSWIFT_H
#define RZ_LIBSWIFT_H

#ifdef __cplusplus
#include <string>

std::string rz_libswift_demangle_line(std::string line);

extern "C" {
#endif

char *rz_libswift_demangle_line(const char *line);

#ifdef __cplusplus
} // extern "C"
#endif

#endif /* RZ_LIBSWIFT_H */