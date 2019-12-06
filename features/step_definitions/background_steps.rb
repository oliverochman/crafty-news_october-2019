Given("the following articles exist:") do |table|
  table.hashes.each do |article_attrs|
    create(:article, article_attrs)
  end
end

Given("the following users exist:") do |table|
  table.hashes.each do |user_attrs|
    create(:user, user_attrs)
  end
end

Given("I am logged in as {string}") do |email|
  user = User.find_by(email: email)

  login_as(user, scope: :user)
end
