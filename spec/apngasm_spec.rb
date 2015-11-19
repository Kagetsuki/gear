require 'spec_helper'
require 'gears/apngasm'

describe Gears::APNGAsm do
  apngasm = Gears::APNGAsm.new

  it 'builds/installs' do
    #expect(apngasm.engage).to eq(true)
    apngasm.obtain
    expect(apngasm.obtained).to eq(true)
    apngasm.build
    expect(apngasm.built).to eq(true)
    apngasm.install
    expect(apngasm.installed).to eq(true)
    apngasm.check
    expect(apngasm.checked).to eq(true)
  end
end
