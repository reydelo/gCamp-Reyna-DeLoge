class Project < ActiveRecord::Base
  has_many :memberships
  has_many :users, through: :memberships
  has_many :tasks
  validates :name, presence: true
end
