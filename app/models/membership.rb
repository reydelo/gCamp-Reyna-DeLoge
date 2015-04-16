class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project

  enum role: {member: 0, owner: 1}

  after_initialize :set_default_role, if: :new_record?

  def set_default_role
    role ||= :membership
  end

  validates :user_id, :presence => true
  validates_uniqueness_of  :user_id, scope: :project_id

end
