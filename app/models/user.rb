class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :trackable, :timeoutable

  has_many :events, dependent: :destroy
  has_many :tasks, through: :events

  enum role: {customer: 0, admin: 1, staff: 2}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.freeze
  VALID_PHONE_REGEX = /\d[0-9]\)*\z/.freeze
  validates :first_name, presence: true,
    length: {maximum: Settings.validation.max_length_50}
  validates :last_name, presence: true,
    length: {maximum: Settings.validation.max_length_50}, allow_blank: false
  validates :phone, presence: true,
    format: {with: VALID_PHONE_REGEX}, allow_blank: true
  validates :email, presence: true,
    length: {maximum: Settings.validation.max_length_255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: true
  validates :password, presence: true, length:
    {minimum: Settings.validation.min_length_6}, allow_nil: true
  before_save{email.downcase!}

  def full_name
    first_name + " " + last_name
  end
end
