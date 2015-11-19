require "gear"

module Gears
  class CMake < Gear
    @gear_name = "CMake"

    def check()
      gear_exec 'cmake --version'
      if $?.exitstatus == 0
        @checked = true
        return true
      end
      @checked = false
      return false
    end

    def obtain()
      github_obtain('Kitware', 'CMake')
    end

    def build()
      Dir.chdir(@build_path)
      `sh bootstrap --prefix=#{@@install_path}`
      `make`
      @built = true
      return true
    end

    def install()
      std_make_install
    end

    def uninstall()
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