require "rails_helper"

RSpec.describe "Sessions", type: :request do
  let(:user) { FactoryBot.create(:user)}
  describe "GET #new" do
    it "responds successfully" do
      get login_path
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    context "user checks the Remember Me Box" do
      it "remembers the cookie" do
        log_in_as(user)
        expect(cookies[:remember_token]).not_to eq nil
      end
    end

    context "user doesn't check the Remember Me Box" do
      it "doesn't remember the cookie" do
        log_in_as(user, remember_me: "0")
        expect(cookies[:remember_token]).to eq nil
      end
    end
  end
end