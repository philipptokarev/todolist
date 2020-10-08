require "rails_helper"

feature "User" do
  let(:user) { create(:user) }

  describe "Sign In" do
    before do
      visit new_user_session_path
    end

    scenario "Successfully" do
      fill_form(:user, email: user.email, password: user.password)
      click_button "Log in"
      expect(page).to have_content("Signed in successfully.")
    end

    scenario "Unsuccessfully" do
      fill_form(:user, email: user.email, password: user.password + "12321")
      click_button "Log in"
      expect(page).to have_content("Invalid Email or password.")
    end

    scenario "Unsuccessfully" do
      fill_form(:user, email: user.email + "1", password: user.password)
      click_button "Log in"
      expect(page).to have_content("Invalid Email or password.")
    end
  end
end
