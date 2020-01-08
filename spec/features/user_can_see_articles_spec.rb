feature 'List articles on index page' do
  context 'with articles in db' do
    before do
      populate_db_with_articles

      visit root_path
    end

    it 'displays first article' do
      expect(page).to have_content 'A breaking News Article'
    end

    it 'displays second article' do
      expect(page).to have_content 'Some other news'
    end
  end
end