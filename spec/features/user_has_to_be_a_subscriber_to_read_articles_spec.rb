feature 'User has to be a subscriber to read articles' do
  let(:subscriber) { create(:user, email: 'thomas@craft.se') }
  let(:non_subscriber) { create(:user, email: 'oliver@craft.se') }

  before do
    @article = create(:article, author: subscriber, title: 'Big News')
  end

  context "Subscriber can access article content" do
    before do
      login_as(subscriber)
      
      visit root_path
      click_on 'Big News'
    end

    it "User should NOT see message about subscription needed" do
      expect(page).to_not have_content 'You have to purchase a subscrition to read this article'
    end
    
    it "User should be on the article show page" do
      expect(current_path).to eq article_path(@article)
    end
    
  end
  
  context "Registered user (non-subscriber) can NOT access article content" do
    before do
      login_as(non_subscriber)

      visit root_path
      click_on 'Big News'
    end

    it "User should see message about subscription needed to read articles" do
      expect(page).to have_content 'You have to purchase a subscrition to read this article'
    end 
  end
  

  context "Not logged in user can NOT access article content" do
    before do
      visit root_path
      click_on 'Big News'
    end

    it "User should see message about subscription needed to read articles" do
      expect(page).to have_content 'You have to purchase a subscrition to read this article'
    end
  end
end