require 'rails_helper'

include Helpers

describe "User" do
  before :each do
    FactoryGirl.create :user
  end

  describe "who has signed up" do
    it "can sign in with right credentials" do
      sign_in(username: "Pekka", password: "Foobar1")

      expect(page).to have_content 'Welcome back!'
      expect(page).to have_content 'Pekka'
    end

    it "is redirected back to sign in form if wrong credentials given" do
      sign_in(username: "Pekka", password: "wrong")

      expect(current_path).to eq(signin_path)
      expect(page).to have_content 'Username and/or password mismatch'
    end
  end

  it "when signed up with good credentials, is added to the system" do
    visit signup_path

    fill_in('user_username', with: 'Brian')
    fill_in('user_password', with: 'Secret55')
    fill_in('user_password_confirmation', with: 'Secret55')

    expect{
      click_button('Create User')
    }.to change{User.count}.by(1)
  end

  describe "who has ratings" do
    it "can see their ratings on their user page" do
      FactoryGirl.create(:beer)

      sign_in(username: "Pekka", password: "Foobar1")

      visit ratings_path
      visit new_rating_path

      fill_in('rating_score', with: 30)
      click_button 'Create Rating'

      expect(page).to have_content "has made 1 rating"
      expect(page).to have_content "anonymous"
    end

    it "can delete their ratings from the system" do
      FactoryGirl.create(:beer)

      sign_in(username: "Pekka", password: "Foobar1")

      visit ratings_path
      visit new_rating_path

      fill_in('rating_score', with: 30)
      click_button 'Create Rating'

      expect{
        page.all('a', text:'delete')[0].click
      }.to change{Rating.count}.from(1).to(0)
    end

    it "can see their favourite beer, brewery and style on their user page" do
      FactoryGirl.create(:beer)

      sign_in(username: "Pekka", password: "Foobar1")

      visit ratings_path
      visit new_rating_path

      fill_in('rating_score', with: 30)
      click_button 'Create Rating'

      expect(page).to have_content "Favorite beer: anonymous, anonymous"
      expect(page).to have_content "Favorite brewery: anonymous"
      expect(page).to have_content "Favorite style: Lager"
    end
  end
end