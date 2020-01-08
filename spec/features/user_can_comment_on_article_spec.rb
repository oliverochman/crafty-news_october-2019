# Feature: User can comment on an article
#   As a user
#   In order to voice my opinions
#   I would like to be able to comment on an article

#   Background:
#     Given the following users exist
#       | email            | subscriber |
#       | thomas@craft.com | true       |

#     And the following articles exist:
#       | title                   |
#       | A breaking News Article |
#       | Some other news         |
#     And I am logged in as "thomas@craft.com"
#     And I am on the index page

#   Scenario: User can comment successfully
#     When I click on "A breaking News Article"
#     And I fill in "Comment" with "This is fake news!!!!"
#     And I click on "Submit comment"
#     Then I should see "Your comment was successfully submited"
#     And I should be at "A breaking News Article" page
#     And I should see "This is fake news!!!!"

#   Scenario: User can not leave empty comment
#     When I click on "A breaking News Article"
#     And I fill in "Comment" with ""
#     And I click on "Submit comment"
#     Then I should see "Something went wrong"
#     And I should be at "A breaking News Article" page

feature 'User can comment on an article' do
  before do
    login_as(create(:user, email: 'thomas@craft.com', subscriber: true))
    populate_db_with_articles
  
    visit root_path
  end

  context 'User can not leave empty comment' do
    before do
      click_on 'A breaking News Article'
      fill_in 'Comment', with: ''
      click_on 'Submit comment'
    end

    it "User should see error message" do
      expect(page).to have_content 'Something went wrong'
    end

    it "User should still be on article show page" do
      article = Article.find_by(title: 'A breaking News Article')

      expect(current_path).to eq article_path(article)
    end
  end

  context 'User can comment successfully' do
    before do
      click_on 'A breaking News Article'
      fill_in 'Comment', with: 'This is fake news!!!!'
      click_on 'Submit comment'
    end

    it "User should see success message" do
      expect(page).to have_content 'Your comment was successfully submited'
    end

    it "User should still be on article show page" do
      article = Article.find_by(title: 'A breaking News Article')

      expect(current_path).to eq article_path(article)
    end

    it "User should see their comment" do
      expect(page).to have_content 'This is fake news!!!!'
    end
  end
end