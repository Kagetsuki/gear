require 'spec_helper'
require 'gears/cmake'

describe Gears::CMake do
  
  cmake = Gears::CMake.new

  it 'defaults to the name CMake' do
    expect(cmake.name).to eq('CMake')
  end

  it 'obtains CMake sources from github' do
    expect(cmake.obtain).to eq(true)
    expect(cmake.obtained).to eq(true)
  end

  it 'builds CMake' do
    expect(cmake.build).to eq(true)
    expect(cmake.built).to eq(true)
  end

  it 'installs (vendorizes) CMake' do
    expect(cmake.install).to eq(true)
    expect(cmake.installed).to eq(true)
  end

  it 'checks CMake was installed and is usable' do
    expect(cmake.check).to eq(true)
    expect(cmake.checked).to eq(true)
  end

  it 'uninstalls CMake' do
    expect(cmake.uninstall).to eq(true)
    expect(cmake.installed).to eq(false)
  end

  it 'removes the CMake repository from the build directory' do
    expect(cmake.remove).to eq(true)
    expect(cmake.obtained).to eq(false)
  end
end