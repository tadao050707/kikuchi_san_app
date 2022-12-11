class CausesController < ApplicationController

  def index
    @first_cause = Cause.where(task_id: params[:task_id]).first
    @task = Task.find(params[:task_id])
    @causes = @task.causes.all
    @cause = @task.causes.build
    if params[:new_cause]
      @causes = Cause.all[-2..-1]
    end
  end

  def show
    @task = Task.find(params[:task_id])
    @cause = @task.causes.build
    @causes = Cause.where(task_id: params[:task_id])
  end

  def new
    if params[:add_new_cause]
      @test = "true"
    end
    task = Task.find(params[:task_id])
    @cause = task.causes.build
    @task = Task.find(params[:task_id])
  end

  def edit
    @cause = Cause.find(params[:id])
    @task = Task.find(params[:task_id])
  end

  def create
    # binding.pry
    if params[:cause][:add_new_cause]
      @test = "true"
    end
    @cause = Cause.new(cause_params)
    @cause.task_id = params[:cause][:task_id]
    if @cause.save
      redirect_to task_causes_path(new_cause: params[:cause][:add_new_cause]), notice: "登録した"
    else
      render :new
    end
  end

  def update
    @cause = Cause.find(params[:id])
    if @cause.update(cause_params)
      redirect_to task_causes_path, notice: '編集した'
    else
      render :edit
    end
  end

  def destroy
    @cause = Cause.find(params[:id])
    @cause.destroy
    redirect_to task_causes_path, notice: 'Cause was successfully destroyed.'
  end

  private

  def cause_params
    params.require(:cause).permit(:task_id, :content, :picture, :movie, :done)
  end
end
