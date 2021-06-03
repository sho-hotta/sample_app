require "rails_helper"

RSpec.describe "users", type: :system do
  describe "user create a new account" do
    context "enter an invalid values" do
      before do
        visit signup_path
        fill_in "Name", with: ""
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        fill_in "Confirmation", with: ""
        click_button "Create my account"
      end

      it "gets errors" do
        expect(page).to have_css "#error_explanation"
        expect(page).to have_css ".alert-danger"
      end

      it "render to /signup url" do
        expect(page.title).to eq "Sign up | Ruby on Rails Tutorial Sample App"
      end
    end
  end
end