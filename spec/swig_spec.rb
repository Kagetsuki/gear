require 'spec_helper'
require 'gears/swig'

describe Gears::SWIG do
  
  swig = Gears::SWIG.new

  it 'defaults to the name SWIG' do
    expect(swig.name).to eq('SWIG')
  end

  it 'obtains, builds, installs, checks, uninstalls and removes SWIG' do
    expect(swig.obtain).to eq(true)
    expect(swig.obtained).to eq(true)

    expect(swig.build).to eq(true)
    expect(swig.built).to eq(true)

    expect(swig.install).to eq(true)
    expect(swig.installed).to eq(true)

    expect(swig.check).to eq(true)
    expect(swig.checked).to eq(true)


    expect(swig.uninstall).to eq(true)
    expect(swig.installed).to eq(false)

    expect(swig.remove).to eq(true)
    expect(swig.obtained).to eq(false)
  end
end



