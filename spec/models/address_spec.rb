require 'rails_helper'

RSpec.describe Address, type: :model do
  describe "Associations" do
    it "belongs to order" do
      assc = described_class.reflect_on_association(:order)
      expect(assc.macro).to eq :belongs_to
    end
  end
  subject { Address.create(first_name: "John", last_name: "Doe",
                           zip_code: "12-345", street: "Test street",
                           email: "john@doe.com", city: "Some city") }
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
end
