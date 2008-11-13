class ReceivedController < ApplicationController
	before_filter :login_required

  def index
		@copies = current_user.received_messages.paginate :per_page => 10,
																												:page 		=> params[:page],
																												:include 	=> :message,
																												:order 		=> "messages.created_at DESC"
  end

  def show
		@copy = current_user.received_messages.find(params[:id])
		@copy.toggle!(:unread) if @copy.unread
  end

end
