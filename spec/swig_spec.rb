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
    expect(swig.install).to eq(true)
    expect(swig.installed).to eq(true)
  end

  it 'checks SWIG was installed and is usable' do
    expect(swig.check).to eq(true)
    expect(swig.checked).to eq(true)
  end

  it 'uninstalls SWIG' do
    expect(swig.uninstall).to eq(true)
    expect(swig.installed).to eq(false)
  end

  it 'removes the SWIG repository from the build directory' do
    expect(swig.remove).to eq(true)
    expect(swig.obtained).to eq(false)
  end
end



