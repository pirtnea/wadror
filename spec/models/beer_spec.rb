require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved when name and style are given correctly" do
    beer = Beer.create name: "Karhu", style: "Lager"

    expect(beer).to be_valid
    expect(Beer.count).to eq(1)
  end

  it "is not saved if name is not given" do
    beer = Beer.create style: "IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end

  it "is not saved if style is not given" do
    beer = Beer.create name: "Punk IPA"

    expect(beer).not_to be_valid
    expect(Beer.count).to eq(0)
  end
end
