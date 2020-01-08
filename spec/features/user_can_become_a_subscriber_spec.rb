feature 'User can become a subscriber', js: true do
  let(:user) { create(:user, email: 'thomas@craft.se') }

  context "User purchases subscription" do
    before do
      @article = create(:article, title: 'Big News')
      login_as(user)
  
      visit root_path
      click_on 'Big News'
      sleep 2
  
      fill_in_stripe_form('Card Number', '4242424242424242')
      fill_in_stripe_form('Expiry date', '1220')
      fill_in_stripe_form('CVC', '123')
      click_on 'Subscribe!'
      sleep 5

    end
  
    it 'User should be redirected to article page' do
      sleep 2
      expect(current_path).to eq article_path(@article)
    end
  
    it 'User should see success message' do
      expect(page).to have_content 'Thank you for becoming a subscriber'
    end
  end
end