require 'rails_helper'

RSpec.describe User, type: :model do
  context "バリデーション" do
    it "名前が入力されていなければ無効" do
      user = User.new(name: "")
      user.valid?
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "名前が51文字以上であれば無効" do
      user = User.new(name: "a" * 51)
      user.valid?
      expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
    end

    it "メールアドレスが入力されていなければ無効" do
      user = User.new(email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    it "メールアドレスが256文字以上であれば無効" do
      user = User.new(email: "a" * 256)
      user.valid?
      expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
    end

    it "メールフォーマットが正しくなければ無効" do
      addresses = %w[user@,com user_at_foo.org username@example.foo@bar_baz.com foo@bar+baz.com foo@bar..com]
      addresses.each do |address|
        user = User.new(email: address)
        user.valid?
        expect(user.errors[:email]).to include("is invalid")
      end
    end

    it "メールフォーマットが正しければ有効" do
      addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
      addresses.each do |address|
        user = User.new(email: address)
        user.valid?
        expect(user.errors[:email]).to eq []
      end
    end

    it "メールアドレスが重複していれば無効" do
      user = User.new(name: "test", email: "test@example.com")
      duplicate_user = user.dup
      user.save
      duplicate_user.valid?
      expect(duplicate_user.errors[:email]).to include("has already been taken")
    end
  end
end