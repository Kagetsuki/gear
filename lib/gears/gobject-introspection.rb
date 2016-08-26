require 'gear'

module Gears
  class GObjectIntrospection < Gear
    @gear_name = "gobject-introspection"

    def check()
      puts 'Checking for GObjectIntrospection'
      gear_exec 'ldconfig -p | grep libgirepository'
      $?.exitstatus == 0 ? true : false
    end

    def obtain()
      puts 'Obtaining GObjectIntrospection sources'
      github_obtain('GNOME', 'gobject-introspection')
      Dir.chdir(@build_path)
      `git checkout tags/1.42.0`
    end

    def build()
      puts "Building GObjectIntrospection in #{@build_path}"
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
