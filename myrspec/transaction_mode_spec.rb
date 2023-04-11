require 'rails_helper'

RSpec.describe TransactionMode, type: :model do
  describe "associations" do
    it { should have_many(:transactions) }
  end

  describe "scopes" do
    describe ".map_id_with_name" do
      it "returns an array of transaction modes mapped by their name and id" do
        create(:transaction_mode, name: "Cash")
        create(:transaction_mode, name: "Credit Card")
        modes = TransactionMode.map_id_with_name
        expect(modes).to eq([["Cash", 1], ["Credit Card", 2]])
      end
    end

    describe ".map_slug_with_name" do
      it "returns an array of transaction modes mapped by their name and slug" do
        create(:transaction_mode, name: "Cash")
        create(:transaction_mode, name: "Credit Card")
        modes = TransactionMode.map_slug_with_name
        expect(modes).to eq([["Cash", "cash"], ["Credit Card", "credit-card"]])
      end
    end
  end

end
