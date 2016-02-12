module UsersHelper
	#gets the user department
	def get_userDept(id)
		@user_dept = Department.select("code").where(["id = ?",id])
	end
	
	#gets the user ticket 
	def get_userTicket(id)
			@user_ticket  = User.select("username").where(["id = ?",id]).first.try(:username)
			if !@user_ticket.nil?
				@user_ticket
			else 
				flash.now[:alert] = 'Could not automaticaly assign! Please put it manualy!'
			end
  end

end
