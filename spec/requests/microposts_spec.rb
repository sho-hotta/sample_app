require "rails_helper"

RSpec.describe "Microposts", type: :request do
  describe "POST #create" do
    context "ユーザーがログインしていない場合" do
      it "投稿できない" do
        expect do
          post microposts_path, params: { micropost: FactoryBot.attributes_for(:micropost)}
        end.to change{ Micropost.count }.by(0)
        expect(response).to redirect_to login_url
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @micropost = FactoryBot.create(:micropost)
      @another_user = FactoryBot.create(:user, name: "user2", email: "user2@example.com")
    end

    context "ユーザーがログインしていない場合" do
      it "削除できない" do
        expect do
          delete micropost_path(@micropost)
        end.to change{ Micropost.count }.by(0)
        expect(response).to redirect_to login_url
      end
    end

    context "自分の投稿したマイクロポストでない場合" do
      it "削除できない" do
        log_in_as(@another_user)
        expect do
          delete micropost_path(@micropost)
        end.to change{ Micropost.count }.by(0)
        expect(response).to redirect_to root_url
      end
    end
  end
end