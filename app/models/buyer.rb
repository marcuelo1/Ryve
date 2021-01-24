# frozen_string_literal: true

class Buyer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  include DeviseTokenAuth::Concerns::User

  has_many :buyer_locations, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  has_many :current_transactions, dependent: :destroy
  has_many :completed_transactions, dependent: :destroy
end
