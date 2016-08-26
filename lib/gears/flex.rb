require 'gear'

module Gears
  class Flex < Gear
    @gear_name = "flex"

    def check()
      puts 'Checking for Flex'
      false
    end

    def obtain()
      puts 'Obtaining Flex sources'
      name = 'flex-2.6.1'
      `wget https://github.com/westes/flex/releases/download/v2.6.1/#{name}.tar.gz`
      `tar -zxvf #{name}.tar.gz`
      `rm #{name}.tar.gz`
      `mv #{name} flex`
    end

    def build()
      puts "Building Flex in #{@build_path}"
      Dir.chdir(@build_path)
      puts "./configure --prefix=#{@@install_path}"
      `./configure --prefix=#{@@install_path}`
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
