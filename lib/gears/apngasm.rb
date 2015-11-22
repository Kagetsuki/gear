require 'gear'

require 'gears/boost'
require 'gears/cmake'

module Gears
  class APNGAsm < Gear
    @gear_name = "APNGAsm"

    def check()
      puts 'Checking for APNGAsm libraries'
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libapngasm'
        @checked = $?.exitstatus == 0 ? true : false
      end
      @checked
    end

    def obtain()
      puts 'Obtaining APNGAsm sources'
      github_obtain('apngasm', 'apngasm')
    end

    def build()
      puts 'Engaging APNGAsm dependencies'
      cm = Gears::CMake.new
      cm_run = Thread.new { cm.engage }
      boost = Gears::Boost.new
      boost_run = Thread.new { boost.engage }
      cm_run.join
      boost_run.join

      puts "Building APNGAsm in #{@build_path}"
      Dir.chdir(@build_path)
      `git checkout swig_interfaces`
      FileUtils.mkdir_p('build') # `mkdir build`
      Dir.chdir('build') # `cd build`
      puts "cmake -DCMAKE_INSTALL_PREFIX=#{@@install_path} .."
      `cmake -DCMAKE_INSTALL_PREFIX=#{@@install_path} ..`
      `make`
      @built = true
      true
    end

    def install()
      puts "Installing APNGAsm to #{@@install_path}"
      Dir.chdir(@build_path + '/build')
      `make install`
      @installed = true
      true
    end

    #TODO uninstall
  end
end
