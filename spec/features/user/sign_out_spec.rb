require "rails_helper"

feature "User sign out" do
  let(:user) { create(:user) }

  scenario "Successfully" do
    login_as(user)
    visit root_path
    expect(page).to have_content("Add TODO List")
    page.driver.submit :delete, destroy_user_session_path, {}
    expect(page).to have_content("Signed out successfully.")
  end
end
