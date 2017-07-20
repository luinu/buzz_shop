class Category < ApplicationRecord
  has_many :products

  validates :name, presence: true
  # :nocov:
  def to_param
    "#{id}-#{name}".parameterize
  end
  # :nocov:
end
