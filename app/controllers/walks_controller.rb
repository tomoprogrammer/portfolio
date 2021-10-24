class WalksController < ApplicationController
  include Common

  def new
    @walk = Walk.new
  end

  def create
    @walk = Walk.new(walk_params)
    @walk.user_id = current_user.id
    if @walk.save
      #Calendar.save_calendar(@walk.created_at.strftime("%Y-%m-%d"))
      date = @walk.created_at.strftime("%Y-%m-%d")
      if Calendar.where(start: date).blank?
        @calendar = Calendar.new({user_id: current_user.id, start: date, end: date})
        @calendar.save
      end
      #c = Calendar.where(start: date)
        #cal = Calendar.where(start: date).count = c.count + @walk.walk_count;  cal.save
      flash[:notice] = '記録が完了しました'
      redirect_to walks_path
    else
      @user = current_user
      @walks = Walk.new
      render :new
    end
  end

  def index
    if params[:date].present?
      date = DateTime.parse(params[:date])
      @walks = Walk.where('created_at >= ?  AND created_at < ?', date, date + 1)
    else
      @walks = Walk.all
    end
    @user = current_user
    @walk_ranking = get_walk_ranking
  end

  def show
    @walk = Walk.find(params[:id])
    @user = @walk.user
    @walk_comment = WalkComment.new

    # Make Ranking
    # walk_sum = Walk.limit(5).order('walk_count desc').group(:user_id).sum(:walk_count)
    # @walk_ranking = []
    # walk_sum.each do |key, value|
    #   user = User.find(key)
    #  @walk_ranking += [user: user, walk_count: value]
    # end

    @walk_ranking = get_walk_ranking
    # binding.irb
  end

  def edit
    @walk = Walk.find(params[:id])
  end

  def update
    @walk = Walk.find(params[:id])
    @walk.count
    if @walk.update(walk_params)
      flash[:notice] = '修正が完了しました'
      redirect_to walk_path(@walk.id)
    else
      render :edit
    end
  end

  def destroy
    @walk = Walk.find(params[:id])
    if Walk.where('created_at >= ?  AND created_at < ?', @walk.created_at.to_date, @walk.created_at.to_date + 1).size <= 1
         date = @walk.created_at.strftime("%Y-%m-%d")
         @calendar.where(start: date, user_id: current_user.id).destroy_all
    end
    @walk.destroy
    redirect_to walks_path
  end

  private

  def walk_params
    params.require(:walk).permit(:walk_count, :memo, :walk_image)
  end
end
