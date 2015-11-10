require "gear"

module Gears
  class SWIG < Gear
    @name = 'SWIG'

    def obtain()
      github_obtain('swig', 'swig')
    end

  end
end

