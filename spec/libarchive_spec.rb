require 'spec_helper'
require 'gears/libarchive'

describe Gears::LibArchive do
  
  libarchive = Gears::LibArchive.new

  it 'defaults to the name libarchive' do
    expect(libarchive.name).to eq('libarchive')
  end

  it 'obtains libarchive sources from github' do
    expect(libarchive.obtain).to eq(true)
    expect(libarchive.obtained).to eq(true)
  end

  it 'builds libarchive' do
    expect(libarchive.build).to eq(true)
    expect(libarchive.built).to eq(true)
  end

  it 'installs (vendorizes) libarchive' do
    expect(libarchive.install).to eq(true)
    expect(libarchive.installed).to eq(true)
  end

  it 'checks libarchive was installed and is usable' do
    expect(libarchive.check).to eq(true)
    expect(libarchive.checked).to eq(true)
  end

  it 'uninstalls libarchive' do
    expect(libarchive.uninstall).to eq(true)
    expect(libarchive.installed).to eq(false)
  end

  it 'removes the libarchive repository from the build directory' do
    expect(libarchive.remove).to eq(true)
    expect(libarchive.obtained).to eq(false)
  end
end