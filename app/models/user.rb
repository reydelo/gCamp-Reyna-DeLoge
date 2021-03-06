class User<ActiveRecord::Base
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

end
