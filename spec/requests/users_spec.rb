require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "GET #index" do
    context "user is logged in" do
      it "responds successfully" do
        @user = FactoryBot.create(:user)
        log_in_as(@user)
        get users_path
        expect(response).to have_http_status(:success)
      end
    end

    context "user isn't logged in" do
      it "doesn't respond successfully" do
        get users_path
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "GET #new" do
    it "responds successfully" do
      get signup_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "valid request" do
      it "adds a user" do
        expect do
          post users_path, params: { user: FactoryBot.attributes_for(:user) }
        end.to change{ User.count }.by(1)
      end
    end

    context "invalid request" do
      it "doesn't add a user" do
        expect do
          post users_path, params: { user: { name: "", email: "", password: "", password_confirmation: "" } }
        end.to change{ User.count }.by(0)
      end
    end
  end

  describe "GET #edit" do
    before do
      @user = FactoryBot.create(:user)
      @other_user = FactoryBot.create(:user, name: "user2", email: "user2@example.com")
    end

    context "user is logged in/user is correct" do
      it "responds successfully" do
        log_in_as(@user)
        get edit_user_path(@user)
        expect(response).to have_http_status(:success)
      end
    end

    context "user isn't logged in" do
      it "doesn't respond successfully" do
        get edit_user_path(@user)
        expect(response).to redirect_to login_url
      end
    end

    context "user isn't correct" do
      it "doesn't respond successfully" do
        log_in_as(@user)
        get edit_user_path(@other_user)
        expect(response).to redirect_to root_url
      end
    end
  end
end