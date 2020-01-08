feature 'User can edit his article' do
  let(:author) { create(:user, email: 'thomas@craft.se') }
  let!(:big_news) { create(:article, title: 'Big News', author: author) }
  let!(:small_news) { create(:article, title: 'Small News', author: create(:user, email: 'oliver@craft.se')) }

  before do
    login_as(author)

    visit root_path
  end

  context "User can NOT edit another users article" do
    before do
      visit edit_article_path(small_news)
    end

    it "User sees error message about being unauthorized" do
      expect(page).to have_content 'You are not authorized to do that'
    end
  end
  

  context "User can NOT see edit button on another users article" do
    before do
      click_on 'Small News'
    end

    it "User cannot see edit button" do
      expect(page).not_to have_content 'Edit'
    end
  end
  
  context "User can edit his own article" do
    before do
      click_on 'Big News'
      click_on 'Edit'
    end
    
    it "User gets redirected to the edit page" do
      expect(current_path).to eq edit_article_path(big_news)
    end
  end
end