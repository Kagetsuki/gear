require 'spec_helper'
require 'gears/apngasm'

describe Gears::APNGAsm do
  apngasm = Gears::APNGAsm.new

  it 'builds/installs' do
    expect(apngasm.engage).to eq(true)
    expect(apngasm.obtained).to eq(true)
    expect(apngasm.built).to eq(true)
    expect(apngasm.installed).to eq(true)
    expect(apngasm.checked).to eq(true)
  end
end
