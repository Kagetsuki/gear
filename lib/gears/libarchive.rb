require "gear"

module Gears
  class LibArchive < Gear
    @gear_name = "libarchive"

    def check()
      if RUBY_PLATFORM.match(/darwin/)
        @checked = gear_exec_mac > 0 ? true : false
      else
        gear_exec 'ldconfig -p | grep libarchive'
        @checked = $?.exitstatus == 0 ? true : false
      end
      return @checked
    end

    def obtain()
      github_obtain('libarchive', 'libarchive', 'release')
    end

    def build()
      # TODO: fix build error
      Dir.chdir(@build_path)
      `git checkout release`
      `build/autogen.sh`
      `./configure --prefix=#{@@install_path} --without-lzo2 --without-nettle --without-xml2`
      `make`
      @built = true
      return true
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
      return true
    end
  end
end
