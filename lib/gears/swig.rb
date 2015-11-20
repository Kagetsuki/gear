require "gear"

module Gears
  class SWIG < Gear
    @gear_name = "SWIG"

    def check()
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'swig -version'
        @checked = $?.exitstatus == 0 ? true : false
      end
      return @checked
    end

    def obtain()
      github_obtain('swig', 'swig')
    end

    def build()
      Dir.chdir(@build_path)
      `sh autogen.sh`
      `sh configure --prefix=#{@@install_path}`
      `make`
      @built = true
      return true
    end

    def install()
      std_make_install
    end

    def uninstall()
      FileUtils.rm_f("#{@@install_path}/bin/swig")
      FileUtils.rm_f("#{@@install_path}/bin/ccache-swig")
      FileUtils.rm_rf("#{@@install_path}/share/swig")
      FileUtils.rm_f("#{@@install_path}/share/man/man1/ccache-swig.1")
      @installed = false
      return true
    end
  end
end
