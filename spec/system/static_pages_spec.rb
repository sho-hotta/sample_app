require "rails_helper"

describe "静的なページの表示機能", type: :system do

  let(:base_title) { "Ruby on Rails Tutorial Sample App" }

  context "home" do
    before do
      visit root_path
    end

    it "homeページを表示" do
      expect(page).to have_content "Sample App"
      expect(page.title).to eq "#{base_title}"
      expect(page).to have_link href: root_path, count: 2
      expect(page).to have_link "Help", href: help_path
      expect(page).to have_link "About", href: about_path
      expect(page).to have_link "Contact", href: contact_path
    end
  end

  context "help" do
    before do
      visit help_path
    end

    it "helpページを表示" do
      expect(page).to have_content "Help"
      expect(page.title).to eq "Help | #{base_title}"
    end
  end

  context "about" do
    before do
      visit about_path
    end

    it "aboutページを表示" do
      expect(page).to have_content "About"
      expect(page.title).to eq "About | #{base_title}"
    end
  end

  context "contact" do
    before do
      visit contact_path
    end

    it "contactページを表示" do
      expect(page).to have_content "Contact"
      expect(page.title).to eq "Contact | #{base_title}"
    end
  end
end