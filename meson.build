project('libswift', 'cpp',
  version: 'v0.1.0-git',
  # Apple library files are Apache 2.0 licensed.
  # library wrapping for rizin is LGPL v3.
  license: ['LGPL3', 'Apache-2.0'],
  default_options : ['cpp_std=c++11'],
  meson_version: '>=0.55.0')

libswift_src = [
    'src/libswift.cpp',
    'src/Context.cpp',
    'src/Demangler.cpp',
    'src/ManglingUtils.cpp',
    'src/NodeDumper.cpp',
    'src/NodePrinter.cpp',
    'src/OldDemangler.cpp',
    'src/OldRemangler.cpp',
    'src/Punycode.cpp',
    'src/Remangler.cpp'
]

warning_flags = []

cxx_cc = meson.get_compiler('cpp')

if cxx_cc.has_argument('-std=gnu++11')
  warning_flags += '-std=gnu++11'
elif cxx_cc.has_argument('-std=c++11')
  warning_flags += '-std=c++11'
endif

if cxx_cc.has_argument('-Wno-maybe-uninitialized')
  warning_flags += '-Wno-maybe-uninitialized'
elif cxx_cc.has_argument('-Wno-uninitialized')
  warning_flags += '-Wno-uninitialized'
endif

if cxx_cc.has_argument('-Wc++11-extensions')
  warning_flags += '-Wc++11-extensions'
endif

libswift = library('swift', libswift_src,
    c_args : warning_flags,
    cpp_args : warning_flags,
    include_directories: include_directories('src'))

libswift_dep = declare_dependency(
    link_with: libswift,
    include_directories: include_directories('.'),
)
