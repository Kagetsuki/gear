require 'spec_helper'
require 'gears/cmake'

describe Gears::CMake do
  
  cmake = Gears::CMake.new

  it 'defaults to the name CMake' do
    expect(cmake.name).to eq('CMake')
  end

  it 'obtains, builds, installs, checks, uninstalls and removes CMake' do
    expect(cmake.obtain).to eq(true)
    expect(cmake.obtained).to eq(true)

    expect(cmake.build).to eq(true)
    expect(cmake.built).to eq(true)

    expect(cmake.install).to eq(true)
    expect(cmake.installed).to eq(true)

    expect(cmake.check).to eq(true)
    expect(cmake.checked).to eq(true)

    expect(cmake.uninstall).to eq(true)
    expect(cmake.installed).to eq(false)

    expect(cmake.remove).to eq(true)
    expect(cmake.obtained).to eq(false)
  end
end
