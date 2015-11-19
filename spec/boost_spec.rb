require 'spec_helper'
require 'gears/boost'

describe Gears::Boost do
  boost = Gears::Boost.new

  it 'builds/installs' do
    #expect(boost.engage).to eq(true)
    boost.obtain
    expect(boost.obtained).to eq(true)
    boost.build
    expect(boost.built).to eq(true)
    boost.install
    expect(boost.installed).to eq(true)
    boost.check
    expect(boost.checked).to eq(true)
  end
end
