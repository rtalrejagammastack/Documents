require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  # let(:expense_category) { create(:expense_category) }
  # let(:sub_category) { create(:sub_category, expense_category: expense_category) }
  # let(:transaction) { create(:transaction, payer: user, expense_sub_category: sub_category) }

  describe 'associations' do
    it { should have_many(:categories).class_name('UserCategory').dependent(:destroy) }
    it { should have_many(:expense_categories).through(:categories) }
    it { should have_many(:expense_sub_categories).through(:expense_categories).source(:sub_categories) }
    it { should have_many(:transactions).class_name('Transaction').with_foreign_key('payer_id').dependent(:destroy) }
    it { should have_many(:receive_transactions).class_name('Transaction').with_foreign_key('payee_id').dependent(:destroy) }
    it { should have_one_attached(:avatar) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:email) }
    it { should validate_length_of(:phone_number).is_equal_to(10) }
  end

  describe 'callbacks' do
    it 'creates default category after create' do
      expect { user }.to change { UserCategory.count }.by(1)
      expect(user.categories.first.name).to eq(User::DEFAULT_CATEGORY)
    end
  end

  describe 'methods' do
    it 'creates a default category with an attached background image' do
      user.create_default_category
      expect(user.categories.count).to eq(1)
      expect(user.categories.first.background.attached?).to eq(true)
    end
  end
end
