class Address < ApplicationRecord
  belongs_to :order
  belongs_to :user
  self.inheritance_column = 'zoink'
  validates :first_name, :last_name, :zip_code, :street, :email, :city, presence: true

end
