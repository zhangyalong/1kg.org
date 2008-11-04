class Message < ActiveRecord::Base
	belongs_to :author, :class_name => "User"
	has_many :message_copies
	#A message may have many recipients, which can be found
	#through the copies. Since each copy belongs to a simple
	#recipient
	has_many :recipients, :through => :message_copies
end
