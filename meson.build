project('libswift', 'cpp',
  version: '0.4.0',
  # Apple library files are Apache 2.0 licensed.
  # library wrapping for rizin is LGPL v3.
  license: ['LGPL3', 'Apache-2.0'],
  default_options : ['cpp_std=c++17'],
  meson_version: '>=0.55.0')

libswift_src = [
    'rz_libswift.cpp',
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

rz_demangler_dep = dependency('rz_demangler')

rizin_plugdir = get_option('rizin_plugdir')
if rizin_plugdir == ''
  rizin_plugdir = rz_demangler_dep.get_variable(pkgconfig: 'plugindir', cmake: 'rz_demangler_PLUGINDIR')
endif

warning_flags = []
libswift_deps = []
libswift_incs = ['.', 'src']

libswift_deps += dependency('rz_util')
libswift_deps += rz_demangler_dep

if cxx_cc.has_argument('-Wno-maybe-uninitialized')
  add_project_arguments('-Wno-maybe-uninitialized', language: ['cpp'])
elif cxx_cc.has_argument('-Wno-uninitialized')
  add_project_arguments('-Wno-uninitialized', language: ['cpp'])
endif

if cxx_cc.has_argument('-Wunused-parameter')
  add_project_arguments('-Wunused-parameter', language: ['cpp'])
endif

if cxx_cc.has_argument('-Wimplicit-fallthrough')
  add_project_arguments('-Wimplicit-fallthrough', language: ['cpp'])
endif

if cxx_cc.has_argument('-Wc++11-extensions')
  add_project_arguments('-Wc++11-extensions', language: ['cpp'])
endif

if cxx_cc.has_argument('-Wc++11-extensions')
  add_project_arguments('-Wc++11-extensions', language: ['cpp'])
endif

if cxx_cc.has_argument('-fvisibility=hidden')
  add_project_arguments('-fvisibility=hidden', language: ['cpp'])
endif

if cxx_cc.has_argument('/EHsc')
  add_project_arguments('/EHsc', language: ['cpp'])
endif

shared_library('swift', libswift_src,
  dependencies: libswift_deps,
  include_directories: include_directories(libswift_incs),
  implicit_include_directories: false,
  install: true,
  install_dir: rizin_plugdir
)
