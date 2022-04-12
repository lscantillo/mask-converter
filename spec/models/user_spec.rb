require 'rails_helper'

RSpec.describe User, type: :model do
  context 'valid factory' do
    it { expect(FactoryBot.build(:user)).to be_valid }
  end
  describe 'Validations' do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
end
