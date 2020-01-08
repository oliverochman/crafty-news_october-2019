feature 'User can create articles' do
  context "Non logged in user receives an error message" do
    before do
      visit root_path
      click_on "New Article" 
    end
    
    it 'User sees error message' do
      expect(page).to have_content 'You need to sign in or sign up before continuing'
    end
    
    it 'User is redirected to login page' do
      expect(current_path).to eq new_user_session_path
    end
  end

  context "Logged in user can create article" do
    before do
      login_as(create(:user, email: 'user@mail.com', password: 'whatever'))

      visit root_path
      click_on "New Article"
      fill_in "Title", with: "Happy holidays"
      fill_in "Content", with: "Buy your gifts now!"
      click_on "Create Article"
    end

    it 'User should be on article show page' do
      article = Article.find_by(title: 'Happy holidays')
      expect(current_path).to eq article_path(article)
    end

    it 'User should see success message' do
      expect(page).to have_content 'Article was successfully created.'
    end

    it 'User should see article title' do
      expect(page).to have_content 'Happy holidays'
    end

    it 'User should see article content' do
      expect(page).to have_content 'Buy your gifts now!'
    end
  end
end