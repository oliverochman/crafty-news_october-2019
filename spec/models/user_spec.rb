require 'rails_helper'

RSpec.describe User, type: :model do
  describe "DB columns" do
    it { is_expected.to have_db_column :email }
    it { is_expected.to have_db_column :encrypted_password }
    it { is_expected.to have_db_column :reset_password_token }
    it { is_expected.to have_db_column :reset_password_sent_at }
    it { is_expected.to have_db_column :remember_created_at }
  end

  it "has a valid Factory" do
    expect(create(:article)).to be_valid
  end
end
