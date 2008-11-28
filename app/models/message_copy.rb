class MessageCopy < ActiveRecord::Base
	belongs_to 	:message, :counter_cache => true
	belongs_to 	:recipient, :class_name => "User"
	delegate :author, :created_at, :subject, :html_content, :recipients, :to => :message
end