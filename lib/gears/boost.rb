require "gear"

module Gears
  class Boost < Gear
    @gear_name = "Boost"

    def check()
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libboost'
        @checked = $?.exitstatus == 0 ? true : false
      end
      return @checked
    end

    def obtain()
      # github_obtain('boostorg', 'boost')
      Dir.chdir(_root_path + '/build')
      return true if Dir.exist? 'Boost'

      `wget http://downloads.sourceforge.net/project/boost/boost/1.59.0/boost_1_59_0.zip`
      `unzip boost_1_59_0.zip`
      `mv boost_1_59_0 Boost`
      FileUtils.rm('boost_1_59_0.zip')
      true
    end

    def build()
      Dir.chdir(@build_path)
      `./bootstrap.sh --without-libraries=python --prefix=#{@@install_path}`
      `./b2 headers`
      `./b2`
      `./b2 install --prefix=#{@@install_path}`
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
