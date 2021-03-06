class User < ActiveRecord::Base
  has_many :surveys
  has_many :selections
  has_many :questions, through: :surveys
  has_many :choices, through: :questions

  validates :email, uniqueness: true
  validates :email, presence: true
  validates_format_of :email, with: /.+@.+\..{2,3}/

  validates :password, presence: true
  validates :password, length: { minimum: 3 }


 include BCrypt
  
  def password
      @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = new_password
    self.password_hash = Password.create(new_password)
  end

  def self.authenticate(email,password)
    @user = User.find_by_email(email)
    return nil unless @user
    p "user.password and passowrd"
    p @user.password
    p password
    @user.password == password ? @user.id : nil
  end
end

