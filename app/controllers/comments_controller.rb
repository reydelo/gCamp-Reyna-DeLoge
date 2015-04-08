class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @project = Project.find(params[:project_id])
    @task = params[:task_id]
    @comment.task_id = params[:task_id]
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to project_task_path(@project, @task), notice: 'Your comment has been posted'
    else
      redirect_to project_task_path(@project, @task)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:user_id, :task_id, :body, :created_at)
  end

end
