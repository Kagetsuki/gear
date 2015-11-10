require "gear"

module Gears
  class SWIG < Gear
    def set_info()
      @name = 'SWIG'
      @version = 'edge'
    end

    def obtain()
      github_obtain('swig', 'swig')
    end


  end
end

