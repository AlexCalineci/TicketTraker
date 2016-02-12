module StatusesHelper
	#gets the status id - used in tickets views
	def get_status(id)
		status = Status.where(["id = ?",id]).first.try(:code)
		status
	end

	#gets the tickets status - cam harcore :D
	def get_ticket_status(ticket_id)
		status_act = Status.where("id in (Select status from tickets where id =?)",ticket_id).first.try(:code)
		status_act
	end

end
