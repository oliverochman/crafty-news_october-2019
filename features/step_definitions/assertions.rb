Then("I should see {string}") do |content|
  expect(page).to have_text content
end

Then("I should be on the {string} page") do |article_title|
  article = Article.find_by(title: article_title)

  expect(current_path).to eq article_path(article)  
end

Then("I should not see {string}") do |element|
  expect(page).not_to have_content element
end