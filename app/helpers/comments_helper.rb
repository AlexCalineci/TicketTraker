module CommentsHelper
	#gets the number of comments on one ticket
	def get_comments_count(ticket_id)
		@comments_count= Comment.where(["ticket_id = ?",ticket_id]).count	
		@comments_count
	end
	
	#gets the ticket comments
	def get_ticket_comments(ticket_id)
		@ticket_comments= Comment.where(["ticket_id = ?",ticket_id])
    @ticket_comments
	end
		
end
