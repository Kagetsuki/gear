require 'spec_helper'
require 'gears/swig'

describe Gears::SWIG do
  
  swig = Gears::SWIG.new

  it 'defaults to the name SWIG' do
    expect(swig.name).to eq('SWIG')
  end

  it 'obtains SWIG sources from github' do
    expect(swig.obtain).to eq(true)
    expect(swig.obtained).to eq(true)
  end

  it 'builds SWIG' do
    expect(swig.build).to eq(true)
    expect(swig.built).to eq(true)
  end

  it 'installs (vendorizes) SWIG' do
  end

  it 'checks SWIG was installed and is usable' do
  end
end



