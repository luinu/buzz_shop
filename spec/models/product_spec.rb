require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:category) { Category.create(name: "Test Category") }

  subject {
    described_class.new(name: "Test name", description: "Some test description",
                        price: 744.90, category_id: category.id)
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without price" do
    subject.price = nil
    expect(subject).to_not be_valid
  end
  it "is not valid if price is equal zero" do
    subject.price = 0.0
    expect(subject).to_not be_valid
  end
  it "is not valid if price is less than zero" do
    subject.price = -599.90
    expect(subject).to_not be_valid
  end
  it "is not valid without description" do
    subject.description = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without category" do
    subject.category = nil
    expect(subject).to_not be_valid
  end
  describe "Associations" do
    it "belongs to one category" do
      assc = described_class.reflect_on_association(:category)
      expect(assc.macro).to eq :belongs_to
    end
  end
  it "is returning parameterized url" do
    expect(subject.to_param).to eq("#{subject.id}-#{subject.name}".parameterize)
  end
  it "is available in warehouse" do
    # ...
  end
end
