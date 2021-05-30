require "rails_helper"

describe "静的なページの表示機能", type: :system do
  context "home" do
    before do
      visit "/static_pages/home"
    end

    it "homeページを表示" do
      expect(page).to have_content "Sample App"
    end
  end

  context "help" do
    before do
      visit "/static_pages/help"
    end

    it "helpページを表示" do
      expect(page).to have_content "Help"
    end
  end

  context "about" do
    before do
      visit "/static_pages/about"
    end

    it "aboutページを表示" do
      expect(page).to have_content "About"
    end
  end
end