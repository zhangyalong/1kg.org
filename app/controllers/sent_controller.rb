class SentController < ApplicationController
	before_filter :login_required

  def index
		@messages = current_messages.undeleted.paginate :per_page => 10,
																										:page  		=> params[:page],
																										:order 		=> "created_at DESC"
  end

  def show
		@message = current_messages.find(params[:id])
  end

  def new
		@message = current_messages.build
  end

  def create
		@message = current_messages.build(params[:message])

		if @message.save
			flash[:notice] = "消息已发出"
			redirect_to index_path
		else
			render :action => "new"
		end
  end

  def destroy
    @message = current_messages.find(params[:id])
    if @message.is_purge?
      @message.destroy
    elsif
      @message.update_attribute('deleted', true)
    end

    flash[:notice] = "你刚刚删除了一条站内消息"
    redirect_to index_path
  end

  private

  def current_messages
    current_user.sent_messages
  end

  def index_path
    user_sent_index_path(current_user)
  end
end
