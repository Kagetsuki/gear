require "gear"

module Gears
  class SWIG < Gear
    @gear_name = "SWIG"

    def check()
      gear_exec 'swig -version'
      if $?.exitstatus == 0
        @checked = true
        return true
      end
      @checked = false
      return false
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
      @installed = false
      return true
    end
  end
end
