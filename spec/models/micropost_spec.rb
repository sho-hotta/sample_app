require 'rails_helper'

RSpec.describe Micropost, type: :model do
  context "バリデーション" do
    before do
      @user = FactoryBot.create(:user)
      @micropost = Micropost.new(content: "TestText")
    end

    it "user_idが存在しなければ無効" do
      @micropost.valid?
      expect(@micropost.errors[:user_id]).to include("can't be blank")
    end

    it "user_idが存在すれば有効" do
      @micropost.user_id = @user.id
      @micropost.valid?
      expect(@micropost.errors[:user_id]).to eq []
    end
  end
end
