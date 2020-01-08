module SessionHelpers
  def populate_db_with_articles 
    articles = file_fixture("articles_index.json").read
    
    JSON.parse(articles).each do |article|      
      create(:article, article)
    end
  end

  def fill_in_stripe_form(field_name, value)
    case field_name
    when 'Card Number'
      stripe_iframe_name = '#card-number div iframe'
      stripe_field_name = 'cardnumber'
    when 'Expiry date'
      stripe_iframe_name = '#card-expiry div iframe'
      stripe_field_name = 'exp-date'
    when 'CVC'
      stripe_iframe_name = '#card-cvc div iframe'
      stripe_field_name = 'cvc'
    end
    within_frame(find(stripe_iframe_name)) do
      page.driver.browser.find_element(name: stripe_field_name).send_keys(value)
    end
  end
end