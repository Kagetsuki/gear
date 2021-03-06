require "gear"

module Gears
  class SWIG < Gear
    @gear_name = "SWIG"

    def check()
      puts 'Checking for SWIG'
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'swig -version'
        @checked = $?.exitstatus == 0 ? true : false
      end
      @checked
    end

    def obtain()
      puts 'Obtaining SWIG'
      github_obtain('swig', 'swig')
    end

    def build()
      puts "Building SWIG in #{@build_path}"
      Dir.chdir(@build_path)
      `./autogen.sh`
      `./configure --prefix=#{@@install_path}`
      `make`
      @built = true
      true
    end

    def install()
      puts "Installing SWIG to #{@@install_path}"
      Dir.chdir(@build_path)
      `make install-main`
      `make install-lib`
      @installed = true
      true
    end

    def uninstall()
      puts 'Uninstalling SWIG'
      FileUtils.rm_f("#{@@install_path}/bin/swig")
      FileUtils.rm_f("#{@@install_path}/bin/ccache-swig")
      FileUtils.rm_rf("#{@@install_path}/share/swig")
      FileUtils.rm_f("#{@@install_path}/share/man/man1/ccache-swig.1")
      @installed = false
      true
    end
  end
end
