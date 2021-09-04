project('libswift', 'cpp',
  version: 'v0.1.0-git',
  # Apple library files are Apache 2.0 licensed.
  # library wrapping for rizin is LGPL v3.
  license: ['LGPL3', 'Apache-2.0'],
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

libswift = library('swift',
    libswift_src,
    include_directories: include_directories('src'))

libswift_dep = declare_dependency(
    link_with: libswift,
    include_directories: include_directories('.'),
)
