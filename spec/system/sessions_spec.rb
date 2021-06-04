require "rails_helper"

RSpec.describe "sessions", type: :system do
  describe "login" do
    before do
      @user = FactoryBot.create(:user)
    end

    context "enter valid values" do
      before do
        visit login_path
        fill_in "Email", with: "user1@example.com"
        fill_in "Password", with: "password"
        click_button "Log in"
      end

      it "login and redirect to /users/params[:id]" do
        expect(page).not_to have_link "Log in", href: login_path
        expect(current_path).to eq user_path(@user)
        click_link "Account"
        expect(page).to have_link "Profile", href: user_path(@user)
        expect(page).to have_link "Log out", href: logout_path
      end
    end

    context "enter valid email/invalid password" do
      before do
        visit login_path
        fill_in "Email", with: "user1@example.com"
        fill_in "Password", with: ""
        click_button "Log in"
      end

      it "gets errors" do
        expect(page).to have_selector ".alert-danger"
      end

      it "render to /signup url" do
        expect(page.title).to eq "Log in | Ruby on Rails Tutorial Sample App"
      end

      it "deletes flash message if page reloads" do
        visit root_path
        expect(page).not_to have_selector ".alert-danger"
      end
    end

    context "enter invalid email/valid password" do
      before do
        visit login_path
        fill_in "Email", with: ""
        fill_in "Password", with: "password"
        click_button "Log in"
      end

      it "gets errors" do
        expect(page).to have_selector ".alert-danger"
      end

      it "render to /signup url" do
        expect(page.title).to eq "Log in | Ruby on Rails Tutorial Sample App"
      end

      it "deletes flash message if page reloads" do
        visit root_path
        expect(page).not_to have_selector ".alert-danger"
      end
    end

    context "enter invalid values" do
      before do
        visit login_path
        fill_in "Email", with: ""
        fill_in "Password", with: ""
        click_button "Log in"
      end

      it "gets errors" do
        expect(page).to have_selector ".alert-danger"
      end

      it "render to /signup url" do
        expect(page.title).to eq "Log in | Ruby on Rails Tutorial Sample App"
      end

      it "deletes flash message if page reloads" do
        visit root_path
        expect(page).not_to have_selector ".alert-danger"
      end
    end
  end
end