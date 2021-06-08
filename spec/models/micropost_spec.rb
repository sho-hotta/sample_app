require 'rails_helper'

RSpec.describe Micropost, type: :model do
  context "バリデーション" do
    before do
      @user = FactoryBot.create(:user)
      @micropost = Micropost.new(content: "TestText", user_id: @user.id)
    end

    it "user_idが存在しなければ無効" do
      @micropost.user_id = nil
      @micropost.valid?
      expect(@micropost.errors[:user_id]).to include("can't be blank")
    end

    it "user_idが存在すれば有効" do
      @micropost.valid?
      expect(@micropost.errors[:user_id]).to eq []
    end

    it "contentが存在しなければ無効" do
      @micropost.content = " "
      @micropost.valid?
      expect(@micropost.errors[:content]).to include("can't be blank")
    end

    it "contentが141文字以上であれば無効" do
      @micropost.content = "a" * 141
      @micropost.valid?
      expect(@micropost.errors[:content]).to include("is too long (maximum is 140 characters)")
    end

    it "contentが140文字であれば有効" do
      @micropost.content = "a" * 140
      @micropost.valid?
      expect(@micropost.errors[:content]).to eq []
    end
  end
end
