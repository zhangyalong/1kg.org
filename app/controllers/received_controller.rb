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
	
	def reply
		@original_message = current_user.received_messages.find(params[:id])
		subject = @original_message.subject.sub(/^(Re: )?/, "Re: ")
		@message = current_user.sent_messages.build(:to => [@original_message.author.id], 
																								:subject => subject) 
		render :template => "sent/new"
	end
end
