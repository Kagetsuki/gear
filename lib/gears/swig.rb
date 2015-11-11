require "gear"

module Gears
  class SWIG < Gear
    @gear_name = "SWIG"

    def obtain()
      github_obtain('swig', 'swig')
    end

    def build()
      Dir.chdir(@build_path)
      `sh autogen.sh`
      `sh configure --prefix#{@@install_path}`
      `make`
    end

  end
end

