require "gear"

module Gears
  class Boost < Gear
    @gear_name = "Boost"

    def check()
      puts 'Checking for Boost'
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libboost'
        @checked = $?.exitstatus == 0 ? true : false
      end
      @checked
    end

    def obtain()
      puts 'Obtaining Boost'
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
      puts "Building Boost in #{@build_path}"
      Dir.chdir(@build_path)
      puts '...boostrapping'
      `./bootstrap.sh --without-libraries=python --prefix=#{@@install_path}`
      puts '...compiling headers'
      `./b2 headers`
      puts '...building'
      `./b2`
      @built = true
      return true
    end

    def install()
      puts "Installing Boost to #{@@install_path}"
      Dir.chdir(@build_path)
      `./b2 install --prefix=#{@@install_path}`
      @installed = true
      true
    end

    def uninstall()
      FileUtils.rm_f(Dir.glob("#{@@install_path}/lib/libboost.*"))
      FileUtils.rm_rf("#{@@install_path}/include/boost")
      @installed = false
      true
    end
  end
end
