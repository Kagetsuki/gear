require 'gear'

require 'gears/libarchive'

module Gears
  class CMake < Gear
    @gear_name = "CMake"

    def check()
      puts 'Checking for CMake'
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'cmake --version'
        @checked = $?.exitstatus == 0 ? true : false
      end
      return @checked
    end

    def obtain()
      puts 'Obtaining CMake'
      github_obtain('Kitware', 'CMake')
    end

    def build()
      puts 'Engaging CMake dependencies'
      la = Gears::LibArchive.new
      la.engage

      puts "Building CMake in #{@build_path}"
      Dir.chdir(@build_path)
      `sh bootstrap --prefix=#{@@install_path}`
      `make`
      @built = true
      return true
    end

    def install()
      puts "Installing CMake to #{@@install_path}"
      std_make_install
    end

    def uninstall()
      puts 'Uninstalling CMake'
      FileUtils.rm_f("#{@@install_path}/bin/ccmake")
      FileUtils.rm_f("#{@@install_path}/bin/cmake")
      FileUtils.rm_f("#{@@install_path}/bin/cmakexbuild")
      FileUtils.rm_f("#{@@install_path}/bin/cpack")
      FileUtils.rm_f("#{@@install_path}/bin/ctest")
      FileUtils.rm_rf(Dir.glob("#{@@install_path}/doc/cmake-*"))
      FileUtils.rm_rf("#{@@install_path}/share/aclocal")
      FileUtils.rm_rf(Dir.glob("#{@@install_path}/share/cmake-*"))
      @installed = false
      return true
    end
  end
end
