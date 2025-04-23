// SPDX-FileCopyrightText: 2025 RizinOrg <info@rizin.re>
// SPDX-FileCopyrightText: 2025 deroad <deroad@kumo.xn--q9jyb4c>
// SPDX-License-Identifier: LGPL-3.0-only

#ifndef SWIFT_DEMANGLING_ASSERT_H
#define SWIFT_DEMANGLING_ASSERT_H

#include <stdexcept>

#define DEMANGLER_ASSERT(expr, node)
#define DEMANGLER_ALWAYS_ASSERT(expr, node)                                    \
  do {                                                                         \
    if (!(expr))                                                               \
      throw std::runtime_error("something went wrong.");                       \
  } while (0)

#endif // SWIFT_DEMANGLING_ASSERT_H