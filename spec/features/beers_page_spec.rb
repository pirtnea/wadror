require 'rails_helper'

include Helpers

describe "Beer" do
  before :each do
    FactoryGirl.create :user
    sign_in(username: "Pekka", password: "Foobar1")
  end

  it "when given a valid name, should be added to the system" do
    visit new_beer_path

    fill_in('beer_name', with: "Asd")

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "when given a name that isn't valid, should give proper error message" do
    visit new_beer_path
    click_button('Create Beer')

    expect(page).to have_content "Name can't be blank"
  end
end