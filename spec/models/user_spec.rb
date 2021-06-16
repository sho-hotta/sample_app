require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end

  context "バリデーション" do
    it "名前が入力されていなければ無効" do
      @user.name = nil
      expect(@user).to be_invalid
    end

    it "名前が51文字以上であれば無効" do
      @user.name = "a" * 51
      expect(@user).to be_invalid
    end

    it "名前が50文字であれば有効" do
      @user.name = "a" * 50
      expect(@user).to be_valid
    end

    it "メールアドレスが入力されていなければ無効" do
      @user.email = nil
      expect(@user).to be_invalid
    end

    it "メールアドレスが256文字以上であれば無効" do
      @user.email = "#{'a' * 244}@example.com"
      expect(@user).to be_invalid
    end

    it "メールフォーマットが正しくなければ無効" do
      addresses = %w[user@,com user_at_foo.org username@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |address|
        @user.email = address
        expect(@user).to be_invalid
      end
    end

    it "メールフォーマットが正しければ有効" do
      addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      addresses.each do |address|
        @user.email = address
        expect(@user).to be_valid
      end
    end

    it "メールアドレスが重複していれば無効" do
      user = User.new(name: "duplicate_user", email: "user1@example.com", password: "foobar", password_confirmation: "foobar")
      expect(user).to be_invalid
    end

    it "メールアドレスが小文字で保存される" do
      user = FactoryBot.create(:user, email: "UsEr2@exAmple.Com")
      expect(user.email).to eq "user2@example.com"
    end

    it "パスワードが入力されていなければ無効" do
      @user.password = nil
      @user.password_confirmation = nil
      expect(@user).to be_invalid
    end

    it "パスワードが5文字以下であれば無効" do
      @user.password = "a" * 5
      @user.password_confirmation = "a" * 5
      expect(@user).to be_invalid
    end

    it "パスワードが6文字であれば有効" do
      @user.password = "a" * 6
      @user.password_confirmation = "a" * 6
      expect(@user).to be_valid
    end
  end
end