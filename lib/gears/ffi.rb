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
      puts "./configure --disable-docs --prefix=#{@@install_path}"
      `"./configure --disable-docs --prefix=#{@@install_path}"`
      puts 'making...'
      `make`
      @built = true
      true
    end

    def install()
      puts "Installing to #{@@install_path}"
      Dir.chdir(@build_path)
      `make install`
      @installed = true
      true
    end

    #TODO uninstall
  end
end
