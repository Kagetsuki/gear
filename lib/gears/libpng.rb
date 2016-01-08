require 'gear'

require 'gears/boost'
require 'gears/cmake'

module Gears
  class LibPNG < Gear
    @gear_name = "LibPNG"

    def check()
      puts 'Checking for libpng libraries'
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libpng'
        @checked = $?.exitstatus == 0 ? true : false
      end
      @checked
    end

    def obtain()
      puts 'Obtaining libpng sources'
      github_obtain('glennrp', 'libpng')
    end

    def build()
      puts 'Engaging libpng dependencies'

      puts "Building libpng in #{@build_path}"
      Dir.chdir(@build_path)
      FileUtils.mkdir_p('build') # `mkdir build`
      Dir.chdir('build') # `cd build`
      puts "cmake -DCMAKE_INSTALL_PREFIX=#{@@install_path} .."
      `cmake -DCMAKE_INSTALL_PREFIX=#{@@install_path} ..`
      `make`
      @built = true
      true
    end

    def install()
      puts "Installing lib to #{@@install_path}"
      Dir.chdir(@build_path + '/build')
      `make install`
      @installed = true
      true
    end

    #TODO uninstall
  end
end
