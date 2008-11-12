class SentController < ApplicationController
	before_filter :login_required

  def index
		@messages = current_messages.paginate :per_page => 10,
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
			redirect_to :action => "index"
		else
			render :action => "new"
		end
  end

	private

	def current_messages
		current_user.sent_messages
	end
end
