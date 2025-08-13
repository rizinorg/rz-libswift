project('libswift', 'cpp',
  version: '0.4.0',
  # Apple library files are Apache 2.0 licensed.
  # library wrapping for rizin is LGPL v3.
  license: ['LGPL3', 'Apache-2.0'],
  default_options : ['cpp_std=c++17'],
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

rizin = find_program('rizin', required: false)
cxx_cc = meson.get_compiler('cpp')

libswift_cpp_args = []
libswift_deps = []
libswift_incs = ['.', 'src']

if cxx_cc.has_argument('-Wno-maybe-uninitialized')
  libswift_cpp_args += '-Wno-maybe-uninitialized'
elif cxx_cc.has_argument('-Wno-uninitialized')
  libswift_cpp_args += '-Wno-uninitialized'
endif

if cxx_cc.has_argument('-Wunused-parameter')
  libswift_cpp_args += '-Wunused-parameter'
endif

if cxx_cc.has_argument('-Wimplicit-fallthrough')
  libswift_cpp_args += '-Wimplicit-fallthrough'
endif

if cxx_cc.has_argument('-Wc++11-extensions')
  libswift_cpp_args += '-Wc++11-extensions'
endif

if cxx_cc.has_argument('-Wc++11-extensions')
  libswift_cpp_args += '-Wc++11-extensions'
endif

if cxx_cc.has_argument('-fvisibility=hidden')
  libswift_cpp_args += '-fvisibility=hidden'
endif

if cxx_cc.has_argument('/EHsc')
  libswift_cpp_args += '/EHsc'
endif

if cxx_cc.has_argument('-fvisibility=hidden')
  libswift_cpp_args += '-fvisibility=hidden'
endif

libswift = static_library('swift', libswift_src,
  cpp_args: libswift_cpp_args,
  dependencies: [],
  implicit_include_directories: false,
  install: false,
  include_directories: include_directories(libswift_incs),
)

libswift_dep = declare_dependency(
    link_with: libswift,
    dependencies: [],
    include_directories: include_directories('.'),
)

if get_option('enable_plugin')
  rz_demangler_dep = dependency('rz_demangler')
  libswift_deps = [
    rz_demangler_dep,
    dependency('rz_util'),
    libswift_dep
  ]

  rizin_plugdir = get_option('rizin_plugdir')
  if rizin_plugdir == ''
    rizin_plugdir = rz_demangler_dep.get_variable(pkgconfig: 'plugindir', cmake: 'rz_demangler_PLUGINDIR')
  endif

  shared_library('swift', 'rz_libswift.cpp',
    dependencies: libswift_deps,
    include_directories: include_directories(libswift_incs),
    implicit_include_directories: false,
    install: true,
    install_dir: rizin_plugdir
  )
endif
