require 'rails_helper'

RSpec.describe TransactionType, type: :model do
  # Ensure the name field is present
  it { should validate_presence_of(:name) }

  # Ensure the friendly_id is generated from the name field
  it { should use_friendly_id(:generated_slug) }

  # Ensure the has_many association with transactions is setup
  it { should have_many(:transactions) }

  # Ensure the map_id_with_name scope returns a hash with id and name keys
  describe ".map_id_with_name" do
    let!(:type1) { create(:transaction_type, name: "Type 1") }
    let!(:type2) { create(:transaction_type, name: "Type 2") }

    it "returns a hash with id and name keys" do
      expect(TransactionType.map_id_with_name).to eq([["Type 1", type1.id], ["Type 2", type2.id]])
    end
  end

  # Ensure the map_slug_with_name scope returns a hash with slug and name keys
  describe ".map_slug_with_name" do
    let!(:type1) { create(:transaction_type, name: "Type 1") }
    let!(:type2) { create(:transaction_type, name: "Type 2") }

    it "returns a hash with slug and name keys" do
      expect(TransactionType.map_slug_with_name).to eq([["type-1", "Type 1"], ["type-2", "Type 2"]])
    end
  end
end
