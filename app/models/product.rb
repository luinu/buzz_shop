class Product < ApplicationRecord
  belongs_to :category
  has_one :stock, dependent: :destroy
  accepts_nested_attributes_for :stock, allow_destroy: true
  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0.0 }, presence: true
  validates :category, presence: true

  mount_uploader :photo, ProductPhotoUploader

  def to_param
    "#{id}-#{name}".parameterize
  end
end
