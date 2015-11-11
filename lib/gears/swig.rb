require "gear"

module Gears
  class SWIG < Gear
    @gear_name = "SWIG"

    def obtain()
      github_obtain('swig', 'swig')
    end

  end
end

