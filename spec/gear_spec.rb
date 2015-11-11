require 'spec_helper'

describe Gear do
  gear = Gear.new

  it 'defaults to the name Gear' do
    expect(gear.name).to eq('Gear')
  end

  it 'defaults to failures for all virtual methods' do
    expect(gear.check).to eq(false)
    expect(gear.obtain).to eq(false)
    expect(gear.build).to eq(false)
    expect(gear.install).to eq(false)
  end
end
