require "rails_helper"

RSpec.describe "users", type: :system do
  describe "user create a new account" do
    context "enter a valid values" do
      before do
        visit signup_path
        fill_in "Name", with: "testuser"
        fill_in "Email", with: "testuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
        click_button "Create my account"
      end

      it "redirect to /users/params[:id]" do
        flash_message = find(".alert-success").text
        expect(flash_message).not_to be_empty
        expect(current_path).to eq user_path(User.last)
      end
    end

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