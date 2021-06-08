require 'rails_helper'

RSpec.describe Micropost, type: :model do
  before do
    @micropost = FactoryBot.create(:micropost)
    @user = @micropost.user
  end

  context "バリデーション" do
    it "user_idが存在しなければ無効" do
      @micropost.user_id = nil
      expect(@micropost).to be_invalid
    end

    it "user_idが存在すれば有効" do
      expect(@micropost).to be_valid
    end

    it "contentが存在しなければ無効" do
      @micropost.content = " "
      expect(@micropost).to be_invalid
    end

    it "contentが141文字以上であれば無効" do
      @micropost.content = "a" * 141
      expect(@micropost).to be_invalid
    end

    it "contentが140文字であれば有効" do
      @micropost.content = "a" * 140
      expect(@micropost).to be_valid
    end
  end

  context "ソート" do
    it "新着順に表示される" do
      @user.microposts.create(content: "day_before_yesterday", created_at: 2.days.ago)
      now = @user.microposts.create(content: "now", created_at: Time.zone.now)
      @user.microposts.create(content: "yesterday", created_at: 1.days.ago)
      expect(Micropost.first).to eq now
    end
  end
end
