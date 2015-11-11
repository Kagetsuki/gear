require "gear"

module Gears
  class APNGAsm < Gear
    @gear_name = "APNGAsm"

    def check()
      gear_exec 'ldconfig -p | grep libapngasm'
      if $?.exitstatus == 0
        @checked = true
        return true
      end
      @checked = false
      return false
    end

    def obtain()
      github_obtain('apngasm', 'apngasm')
    end

    def build()
      Dir.chdir(@build_path)
      `mkdir build`
      `cd build`
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
