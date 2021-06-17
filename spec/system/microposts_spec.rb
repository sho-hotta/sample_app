require "rails_helper"

RSpec.describe "microposts", type: :system do
  describe "マイクロポストのインターフェイス" do
    before do
      @micropost = FactoryBot.create(:micropost)
      @user = @micropost.user
      34.times do
        content = Faker::Lorem.sentence(word_count: 5)
        @user.microposts.create(content: content)
      end
      login_as(@user)
      click_on "Home"
    end

    it "空の投稿は無効" do
      click_on "Post"
      expect(page).to have_css ".alert-danger"
    end

    it "ページネーションが正しく動作する" do
      click_on "2"
      expect(URI.parse(current_url).query).to eq "page=2"
    end

    it "有効な投稿が保存される" do
      fill_in "micropost_content", with: "valid_content"
      attach_file "micropost_image", "#{Rails.root}/spec/fixtures/Untitled.png"
      expect do
        click_on "Post"
        expect(current_path).to eq root_path
        expect(page).to have_css ".alert-success"
        expect(page).to have_selector "img[src$='Untitled.png']"
      end.to change{ Micropost.count }.by(1)
    end

    it "投稿を削除できる" do
      page.accept_confirm do
        all("ol li")[0].click_on "delete"
      end
      expect do
        expect(current_path).to eq root_path
        expect(page).to have_css ".alert-success"
      end.to change{ Micropost.count }.by(-1)
    end

    it "他のユーザーの投稿の削除リンクは表示されない" do
      @another_user = FactoryBot.create(:user, name: "user2", email: "user2@example.com")
      @another_user.microposts.create(content: "test")
      visit user_path(@another_user)
      expect(@another_user.microposts.count).to eq 1
      expect(page).not_to have_link "delete"
    end
  end
end