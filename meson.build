project('libswift', 'cpp',
  version: '0.3.0',
  # Apple library files are Apache 2.0 licensed.
  # library wrapping for rizin is LGPL v3.
  license: ['LGPL3', 'Apache-2.0'],
  default_options : ['cpp_std=c++11'],
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

rizin_incdir = get_option('rizin_incdir')
if rizin_incdir == '' and rizin.found()
  rizin_incdir = run_command(rizin, '-H', 'RZ_INCDIR').stdout().strip()
endif

rizin_libdir = get_option('rizin_libdir')
if rizin_libdir == '' and rizin.found()
  rizin_libdir = run_command(rizin, '-H', 'RZ_LIBDIR').stdout().strip()
endif

rizin_plugdir = get_option('rizin_plugdir')
if rizin_plugdir == '' and rizin.found()
  rizin_plugdir = run_command(rizin, '-H', 'RZ_USER_PLUGINS').stdout().strip()
  if rizin_plugdir == ''
    rizin_plugdir = get_option('libdir')
  endif
endif

warning_flags = []
libswift_deps = []
libswift_incs = ['.', 'src']

if rizin_libdir != ''
  libswift_deps += cxx_cc.find_library('rz_util', dirs: rizin_libdir)
  libswift_deps += cxx_cc.find_library('rz_demangler', dirs: rizin_libdir)
endif

if rizin_incdir != ''
  libswift_incs += rizin_incdir
  libswift_incs += rizin_incdir + '/sdb'
endif

if cxx_cc.has_argument('-Wno-maybe-uninitialized')
  add_project_arguments('-Wno-maybe-uninitialized', language: ['cpp'])
elif cxx_cc.has_argument('-Wno-uninitialized')
  add_project_arguments('-Wno-uninitialized', language: ['cpp'])
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

shared_library('swift', libswift_src,
  dependencies: libswift_deps,
  include_directories: include_directories(libswift_incs),
  implicit_include_directories: false,
  install: true,
  install_dir: rizin_plugdir
)
