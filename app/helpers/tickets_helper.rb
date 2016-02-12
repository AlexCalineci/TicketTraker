module TicketsHelper
	#counts the number of all tickets	
	def count
	 @tot =	Ticket.count
	end

	#counts the assigned tickets
  def count_asig_ticket(id)
		@user_ticket = Ticket.where(["asigned_to_operator = ? and length(resolved_by_operator) =0",id]).count
	end

	#counts the posted by user tickets
	def count_posted_by(id)
		@user_ticket = Ticket.where(["user_id = ?",id]).count	
	end

	#counts the resolved by user tickets
  def count_resolved_by(id)
		@user_ticket = Ticket.where(["resolved_by_operator = ?",id]).count	
	end
  
	#auto_assign !?!?!?
	def auto_assign(dept_id,user_id,ticket_id)
		ids = User.select(:id).where(:department_id => dept_id)	
			@get_tickets_resolved  = Ticket.select("resolved_by_operator, count(*) tot_rez").where(["coalesce(resolved_by_operator,'ERR') in (?,'ERR')",ids]).group("resolved_by_operator")
				@get_tickets_resolved.sort_by{|u| u.tot_rez}
				tr_max  = @get_tickets_resolved.first
				tr_min  = @get_tickets_resolved.last
				tr_max_id  = @get_tickets_resolved.first.resolved_by_operator
				tr_min_id  = @get_tickets_resolved.last.resolved_by_operator
				get_assigned_to_tr_max_id = count_asig_ticket(tr_max_id)
				get_assigned_to_tr_min_id = count_asig_ticket(tr_min_id)
				#get_assigned_to_tr_min_id		
				if (get_assigned_to_tr_max_id < get_assigned_to_tr_min_id) and (tr_max_id != user_id)
					Ticket.where("id = ?",ticket_id).update_all(:asigned_to_operator =>tr_max_id)
					tr_max_id
				else (get_assigned_to_tr_max_id > get_assigned_to_tr_min_id) and (tr_min_id != user_id)
					Ticket.where("id = ?",ticket_id).update_all(:asigned_to_operator =>tr_min_id)
					tr_min_id
				end
		  
	end

		
end
