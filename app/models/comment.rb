class Comment < ActiveRecord::Base
	belongs_to :ticket
	belongs_to :user

	attr_accessible :text,
									:ticket_id,
									:user_id

	#validates :user_id, presence: true

end
