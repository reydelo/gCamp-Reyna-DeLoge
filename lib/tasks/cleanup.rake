task :cleanup => :environment do

  Membership.where(user_id: nil).destroy_all
  Membership.where(project_id: nil).destroy_all
  Membership.all.each do |membership|
    if membership.user.nil? || membership.project.nil?
      membership.destroy
    end
  end

  Task.where(project_id: nil).destroy_all
  Task.all.each do |task|
    if task.project.nil?
      task.destroy
    end
  end

  Comment.where(task_id: nil).destroy_all
  Comment.all.each do |comment|
    if comment.user.nil?
      comment.user_id = nil
      comment.save
    end
    if comment.task.nil?
      comment.destroy
    end
  end

end
