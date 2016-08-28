require 'gear'

module Gears
  class FFI < Gear
    @gear_name = "libffi"

    def check()
      puts 'Checking for libffi'
      false
    end

    def obtain()
      puts 'Obtaining libffi sources'
      github_obtain('libffi', 'libffi')
    end

    def build()
      puts "Building ffi in #{@build_path}"
      Dir.chdir(@build_path)
      puts "./autogen.sh"
      `./autogen.sh`
      puts "./configure --disable-docs --prefix=#{@@install_path} --includedir=#{@@install_path}/include"
      `./configure --disable-docs --prefix=#{@@install_path} --includedir=#{@@install_path}/include`
      puts 'making...'
      `make`
      @built = true
      true
    end

    def install()
      puts "Installing to #{@@install_path}"
      Dir.chdir(@build_path)
      `make install`
      `cp -ar #{@@install_path}/lib/libffi-3.99999/include/* #{@@install_path}/include/`
      @installed = true
      true
    end

    #TODO uninstall
  end
end
