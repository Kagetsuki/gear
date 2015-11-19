require "gear"

module Gears
  class LibArchive < Gear
    @gear_name = "libarchive"

    def check()
      gear_exec 'ldconfig -p | grep libarchive'
      if $?.exitstatus == 0
        @checked = true
        return true
      end
      @checked = false
      return false
    end

    def obtain()
      github_obtain('libarchive', 'libarchive')
    end

    def build()
      Dir.chdir(@build_path)
      `sh build/autogen.sh`
      `./configure --prefix=#{@@install_path}`
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