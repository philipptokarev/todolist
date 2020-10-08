require "rails_helper"

feature "User sign up" do
  let(:registered_user) { create(:user) }

  scenario "Successfully" do
    visit root_path
    click_link "Sign Up"
    fill_in "user[email]", with: "tokphil@mail.ru"
    fill_in "user[password_confirmation]", with: "qwerty"
    fill_in "user[password]", with: "qwerty"
    click_button "Sign up"
    expect(page).to have_content("Welcome! You have signed up successfully.")
  end

  scenario "Not successfully" do
    visit root_path
    click_link "Sign Up"
    fill_in "user[email]", with: registered_user.email
    fill_in "user[password_confirmation]", with: "qwerty"
    fill_in "user[password]", with: "qwerty"
    click_button "Sign up"
    expect(page).to have_content("Please review the problems below")
  end
end
