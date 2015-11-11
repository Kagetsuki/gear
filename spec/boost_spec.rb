require 'spec_helper'
require 'gears/boost'

describe Gears::Boost do
  boost = Gears::Boost.new

  it 'builds/installs' do
    expect(boost.engage).to eq(true)
    expect(boost.obtained).to eq(true)
    expect(boost.built).to eq(true)
    expect(boost.installed).to eq(true)
    expect(boost.checked).to eq(true)
  end
end
