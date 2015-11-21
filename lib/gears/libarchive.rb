require "gear"

module Gears
  class LibArchive < Gear
    @gear_name = "libarchive"

    def check()
      puts 'Checking for libarchive'
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libarchive'
        @checked = $?.exitstatus == 0 ? true : false
      end
      @checked
    end

    def obtain()
      puts 'Obtaining libarchive'
      # github_obtain('libarchive', 'libarchive', 'release')
      return true if File.exist? 'libarchive'
      Dir.chdir(_root_path + '/build')
      `wget http://www.libarchive.org/downloads/libarchive-3.1.2.zip`
      `unzip libarchive-3.1.2.zip`
      `mv libarchive-3.1.2 libarchive`
    end

    def build()
      puts "Building libarchive in #{@build_path}"
      # TODO: fix build error
      Dir.chdir(@build_path)
      # `git checkout release`
      # `sh build/autogen.sh`
      puts '...configuring'
      `./configure --prefix=#{@@install_path} --without-lzo2 --without-nettle --without-xml2`
      puts '...making'
      `make`
      @built = true
      true
    end

    def install()
      std_make_install
    end

    def uninstall()
      FileUtils.rm_f("#{@@install_path}/bin/bsdcat")
      FileUtils.rm_f("#{@@install_path}/bin/bsdcpio")
      FileUtils.rm_f("#{@@install_path}/bin/bsdtar")
      FileUtils.rm_f("#{@@install_path}/include/archive_entry.h")
      FileUtils.rm_f("#{@@install_path}/include/archive.h")
      FileUtils.rm_f(Dir.glob("#{@@install_path}/lib/libarchive.*"))
      FileUtils.rm_rf("#{@@install_path}/lib/pkgconfig")
      FileUtils.rm_f("#{@@install_path}/share/man/man1/bsdcat.1")
      FileUtils.rm_f("#{@@install_path}/share/man/man1/bsdcpio.1")
      FileUtils.rm_f("#{@@install_path}/share/man/man1/bsdtar.1")
      FileUtils.rm_rf("#{@@install_path}/share/man/man3")
      FileUtils.rm_rf("#{@@install_path}/share/man/man5")
      @installed = false
      true
    end
  end
end
