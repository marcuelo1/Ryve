# frozen_string_literal: true

class Seller < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :product_categories, dependent: :destroy
  has_many :products, through: :product_categories

  has_many :tags, dependent: :destroy
  has_one :schedule, dependent: :destroy
  has_many :carts, dependent: :destroy

  # Media
  has_one_attached :profile_image
  has_one_attached :background_image

  # geocdoe
  geocoded_by :location
  after_validation :geocode, if: :location_changed?

  # Pg Search
  include PgSearch::Model
  pg_search_scope :store_search, associated_against: {
    products: :name,
    product_categories: :name
  }

end
