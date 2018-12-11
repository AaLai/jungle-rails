class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews

  validates :password, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 5 }

  validates :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }

  validates :first_name, presence: true
  validates :last_name, presence: true

  def self.authenticate_with_credentials(email, password)
    @email = email.lstrip.rstrip.downcase
    @user = User.find_by_email(@email)
    if @user && @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

end
