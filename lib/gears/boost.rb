require "gear"

module Gears
  class Boost < Gear
    @gear_name = "Boost"

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
      FileUtils.rm("#{@@install_path}/bin/swig")
      FileUtils.rm("#{@@install_path}/bin/ccache-swig")
      FileUtils.rm_rf("#{@@install_path}/share/swig")
      @installed = false
      return true
    end
  end
end
