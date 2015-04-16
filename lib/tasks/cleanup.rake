task :cleanup => :environment do

  task :delete_old_user_memberships => :environment do
    desc "Remove all memberships where their users have already been deleted"
    Membership.where(user_id: nil).destroy_all
  end

  task :delete_old_project_memberships => :environment do
    desc "Remove all memberships where their projects have been deleted"
    Membership.where(project_id: nil).destroy_all
  end

  task :remove_membership_if_null_associations => :environment do
    desc "Remove any memberships with a null project_id or user_id"
    Membership.all.each do |membership|
      if membership.user.nil? || membership.project.nil?
        membership.destroy
      end
    end
  end

  task :remove_projects_with_no_members => :environment do
    desc "Remove any projects with no memberships"
    Project.all.each do |project|
      if project.memberships.count == 0
        puts "Destroying #{project}"
        project.destroy
      end
    end
  end

  task :delete_orphan_tasks => :environment do
    desc "Remove all tasks where their projects have been deleted"
    Task.where(project_id: nil).destroy_all
  end

  task :delete_tasks_if_null_association => :environment do
    desc "Remove any task with null project_id"
    Task.all.each do |task|
      if task.project.nil?
        task.destroy
      end
    end
  end

  task :delete_orphan_comments => :environment do
    desc "Remove all comments where their tasks have been deleted"
    Comment.where(task_id: nil).destroy_all
  end

  task :set_comment_user_id_to_nil => :environment do
    desc "Set the user_id of comments to nil if their users have been deleted"
    Comment.all.each do |comment|
      if comment.user.nil?
        comment.user_id = nil
        comment.save
      end
    end
  end

  task :delete_comments_if_null_association => :environment do
    desc "Remove any comments with a null task_id"
    Comment.all.each do |comment|
      if comment.task.nil?
        comment.destroy
      end
    end
  end

end
