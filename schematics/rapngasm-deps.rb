require 'gear'
require 'gears/libpng'
require 'gears/libarchive'
require 'gears/cmake'
require 'gears/boost'
require 'gears/gettext'
require 'gears/flex'
require 'gears/ffi'
require 'gears/gobject-introspection'
require 'gears/apngasm'
require 'gears/swig'

def pack(g)
  g.obtain
  g.build
  g.install
end

pack(Gears::LibArchive.new)
pack(Gears::CMake.new)
pack(Gears::LibPNG.new)
pack(Gears::Boost.new)
pack(Gears::Gettext.new)
pack(Gears::Flex.new)
pack(Gears::FFI.new)
pack(Gears::GObjectIntrospection.new)
pack(Gears::APNGAsm.new)
pack(Gears::SWIG.new)
