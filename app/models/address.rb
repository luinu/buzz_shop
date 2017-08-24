class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user
  validates :first_name, :last_name, :zip_code, :street, :email, :city, presence: true
end
