class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :quotes
   
    # validates_uniqueness_of :email 
    # validates_presence_of :email
    # validates_uniqueness_of :email
    # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: True
    # validate :password, presence: true
    # validate :password, confirmation: { case_sensitive: true }


end