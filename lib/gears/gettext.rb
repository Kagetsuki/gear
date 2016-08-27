require 'gear'

module Gears
  class Gettext < Gear
    @gear_name = "Gettext"

    def check()
      puts 'Checking for Gettext'
      gear_exec 'ldconfig -p | grep libgettext'
      $?.exitstatus == 0 ? true : false
    end

    def obtain()
      puts 'Obtaining Gettext sources'
      name = 'gettext-0.19.8'
      `wget http://ftp.gnu.org/pub/gnu/gettext/#{name}.tar.gz`
      `tar -zxvf #{name}.tar.gz`
      `rm #{name}.tar.gz`
      `mv #{name} #{@gear_name}`
    end

    def build()
      puts "Building Gettext in #{@build_path}"
      Dir.chdir(@build_path)
      puts "./configure --prefix=#{@@install_path}"
      `./configure --prefix=#{@@install_path}`
      puts 'making...'
      `make`
      @built = true
      true
    end

    def install()
      puts "Installing lib to #{@@install_path}"
      Dir.chdir(@build_path)
      `make install`
      @installed = true
      true
    end

    #TODO uninstall
  end
end
