require "gear"

module Gears
  class Boost < Gear
    @gear_name = "Boost"

    def check()
      gear_exec 'ldconfig -p | grep libboost'
      if $?.exitstatus == 0
        @checked = true
        return true
      end
      @checked = false
      return false
    end

    def obtain()
      github_obtain('boostorg', 'boost')
    end

    def build()
      Dir.chdir(@build_path)
      `sh bootstrap.sh --without-libraries=python --prefix=#{@@install_path}`
      `sh b2 headers`
      `sh b2`
      `sh b2 install --prefix=#{@@install_path}`
      @built = true
      return true
    end

    def install()
      std_make_install
    end

    def uninstall()
      #TODO
    end
  end
end
