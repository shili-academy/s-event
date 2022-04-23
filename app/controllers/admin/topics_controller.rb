class Admin::TopicsController < Admin::AdminsController
  load_and_authorize_resource


  def index
    @topics = Topic.order(created_at: :desc)
  end

  def show
    @tasks = @topic.tasks
    @data_chart = {
      organizational_chart: Statistic::OrganizationalChartDataService.new({topic: @topic, tasks: @tasks}).perform
    }
  end

  def new; end

  def create
    @topic = Topic.new topic_params
    if @topic.save
      flash[:success] = "Tạo topic thành công"
      redirect_to admin_topic_path @topic
    else
      flash.now[:error] = @topic.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @topic.update topic_params
        format.html{redirect_to admin_topic_path(@topic), success: "Cập nhật thông tin topic thành công"}
        format.json{render :show, status: :ok, location: @topic}
      else
        format.html{render :edit, status: :unprocessable_entity}
        format.json{render json: @topic.errors, status: :unprocessable_entity}
      end
    end
  end

  def destroy
    @topic.destroy
    flash[:success] = "Xóa sự kiện thành công"
    redirect_to admin_topics_path
  end

  private

  def topic_params
    params.require(:topic).permit :name, :description
  end
end
