require "rails_helper"

RSpec.describe "users", type: :system do
  describe "user creates a new account" do
    context "enter a valid values" do
      before do
        visit signup_path
        fill_in "Name", with: "testuser"
        fill_in "Email", with: "testuser@example.com"
        fill_in "Password", with: "password"
        fill_in "Confirmation", with: "password"
        click_button "Create my account"
      end

      it "redirect to /users/:id" do
        flash_message = find(".alert-success").text
        expect(flash_message).not_to be_empty
        expect(current_path).to eq user_path(User.last)
        expect(page).not_to have_link "Log in", href: login_path
        click_link "Account"
        expect(page).to have_link "Profile", href: user_path(User.last)
        expect(page).to have_link "Log out", href: logout_path
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

  describe "user updates account" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user, name: "user2", email: "user2@example.com")
    end

    context "user is logged in/user is correct" do
      before do
        login_as(@user)
        click_on "Account"
        click_on "Settings"
      end

      context "enter a valid values" do
        before do
          fill_in "Name", with: "Foo Bar"
          fill_in "Email", with: "foo@bar.com"
          fill_in "Password", with: ""
          fill_in "Confirmation", with: ""
          click_on "Save changes"
        end

        it "redirect to /users/:id" do
          flash_message = find(".alert-success").text
          expect(flash_message).not_to be_empty
          expect(current_path).to eq user_path(@user)
        end
      end

      context "enter an invalid values" do
        before do
          fill_in "Name", with: " "
          fill_in "Email", with: "user@invalid"
          fill_in "Password", with: "foo"
          fill_in "Confirmation", with: "bar"
          click_on "Save changes"
        end

        it "gets errors" do
          expect(page).to have_css "#error_explanation"
          expect(page).to have_css ".alert-danger"
        end

        it "render to /users/:id/edit url" do
          expect(page.title).to eq "Edit user | Ruby on Rails Tutorial Sample App"
        end
      end
    end

    context "user isn't logged in" do
      it "redirect to /login" do
        visit edit_user_path(@user)
        patch user_path(@user), params: { user: {
          name: @user.name,
          email: @user.email,
        } }
        expect(current_path).to eq login_path
      end
    end

    # context "user isn't correct" do
    #   it "redirect to /root" do
    #     login_as(@user)
    #     visit edit_user_path(@other_user)
    #     expect(current_path).to eq root_path
    #   end
    # end
  end
end