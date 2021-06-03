require "rails_helper"

RSpec.describe "Users", type: :request do
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
end