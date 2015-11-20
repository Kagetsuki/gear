require 'gear'

require 'gears/boost'
require 'gears/cmake'

module Gears
  class APNGAsm < Gear
    @gear_name = "APNGAsm"

    def check()
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libapngasm'
        @checked = $?.exitstatus == 0 ? true : false
      end
      return @checked
    end

    def obtain()
      github_obtain('apngasm', 'apngasm')
    end

    def build()
      # prerequisites
      cm = Gears::CMake.new
      cm.engage
      boost = Gears::Boost.new
      boost.engage

      Dir.chdir(@build_path)
      FileUtils.mkdir_p('build') # `mkdir build`
      Dir.chdir('build') # `cd build`
      gear_exec 'cmake -DCMAKE_INSTALL_PREFIX:PATH=#{@@install_path} ..'
      gear_exec 'make'
      @built = true
      return true
    end

    def install()
      std_make_install
    end

    #TODO uninstall
  end
end
