require 'spec_helper'
require 'gears/libarchive'

describe Gears::LibArchive do
  
  libarchive = Gears::LibArchive.new

  it 'defaults to the name libarchive' do
    expect(libarchive.name).to eq('libarchive')
  end

  it 'obtains, builds, installs, checks, uninstalls and removes libarchive' do
    expect(libarchive.obtain).to eq(true)
    expect(libarchive.obtained).to eq(true)

    expect(libarchive.build).to eq(true)
    expect(libarchive.built).to eq(true)

    expect(libarchive.install).to eq(true)
    expect(libarchive.installed).to eq(true)

    expect(libarchive.check).to eq(true)
    expect(libarchive.checked).to eq(true)

    expect(libarchive.uninstall).to eq(true)
    expect(libarchive.installed).to eq(false)

    expect(libarchive.remove).to eq(true)
    expect(libarchive.obtained).to eq(false)
  end
end
