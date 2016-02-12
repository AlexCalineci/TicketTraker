class TicketsController < ApplicationController
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]
 
  before_filter :authenticate_user!
	WillPaginate.per_page = 10

  # GET /tickets
  # GET /tickets.json
  def index
  	@tickets = Ticket.paginate(:page => params[:page]).order("created_at desc")
  end
	

  # GET /tickets/1
  # GET /tickets/1.json
  def show
		#sets the ticket wp/resolved/new/assigned status
		set_wp(params[:id])
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
	end

  # GET /tickets/1/edit
  def edit
			
  end

	#view the tickets assigned to current user
	def asigned_to
		@asig_tickets = Ticket.where(["asigned_to_operator= ? and length(resolved_by_operator) =0",current_user.id]).paginate(:page => params[:page]).order("created_at desc")  
	end

	#view the tickets posted by current user	
  def posted_by
    @posted_tickets = Ticket.where(["user_id = ? ",current_user.id]).paginate(:page => params[:page]).order("created_at desc")
	end

	#view the tickets resolved by current user
  def resolved_by
    @resolved_tickets = Ticket.where(["resolved_by_operator = ? ",current_user.id]).paginate(:page =>params[:page]).order("created_at desc")
	end

  #view the ticket comments
	def comments_by_tickets
		@ticket_comments= Comment.where(["ticket_id = ?",params[:ticket_id]])
    @ticket_comments
	end
	
	#get the status_id by code
	def get_status_id(code)
		stat = Status.select(:id).where(["code = ?",code]).first.try(:id).to_s
	end

	#transfered from helper method
	def count_asig_ticket(id)
		@user_ticket = Ticket.where(["asigned_to_operator = ? and length(resolved_by_operator) =0",id]).count
	end

	#used in show view
	def set_status(id)

		status = Ticket.select(:status).where(["id=?",id]).first.try(:status)
	
		asigned = Ticket.select(:asigned_to_operator).where(["id= ?",id]).first.try(:asigned_to_operator)
		if asigned.nil?
			asigned  = []
		else
			asigned
		end 
		resolved = Ticket.select(:resolved_by_operator).where(["id=?",id]).first.try(:resolved_by_operator)
		if resolved.nil?
			resolved = []
		else 
			asigned
		end

		case 
			when status.nil?
				Ticket.where("id = ?",id).update_all(:status =>get_status_id("New"))
			when (resolved.length == 0 and status != get_status_id("Wp") and asigned.length != 0)  
				Ticket.where("id = ?",id).update_all(:status =>get_status_id("Assigned"))
			when (resolved.length != 0 and asigned.length != 0) 
				Ticket.where("id = ?",id).update_all(:status =>get_status_id("Resolved"))	
			end
		
	end

	#used in show view
	def set_wp(id)	
		state = ""
		if params[:set_wp] == "Claim IT"
				Ticket.where('id= ?', id).update_all(:status =>get_status_id("Wp"))
				state = "wp"
		elsif state.mb_chars.length == 0
				set_status(id)
		else 
			state = "New"
		end
	end

	def auto_assign(ticket_id)
		dept_id = Ticket.select(:department_id).where(["id=?",ticket_id]).first.try(:department_id)
		user_id = Ticket.select(:user_id).where(["id=?",ticket_id]).first.try(:user_id)
		@ids = User.select(:id).where(:department_id => dept_id)	
			@get_tickets_resolved  = Ticket.select("resolved_by_operator, count(*) tot_rez").where(["resolved_by_operator in (?)",@ids]).group("resolved_by_operator")
				@get_tickets_resolved.sort_by{|u| u.tot_rez}
				tr_max  = @get_tickets_resolved.first
				tr_min  = @get_tickets_resolved.last
				tr_max_id  = @get_tickets_resolved.first.try(:resolved_by_operator)
				tr_min_id  = @get_tickets_resolved.last.try(:resolved_by_operator)
				if tr_max_id != tr_min_id
					get_assigned_to_tr_max_id = count_asig_ticket(tr_max_id)
					get_assigned_to_tr_min_id = count_asig_ticket(tr_min_id)	
					if (get_assigned_to_tr_max_id < get_assigned_to_tr_min_id)
						Ticket.where("id = ?",ticket_id).update_all(:asigned_to_operator =>tr_max_id)
						#tr_max_id
					elsif (get_assigned_to_tr_max_id > get_assigned_to_tr_min_id)
						Ticket.where("id = ?",ticket_id).update_all(:asigned_to_operator =>tr_min_id)
					elsif (get_assigned_to_tr_max_id == get_assigned_to_tr_min_id)
						Ticket.where("id = ?",ticket_id).update_all(:asigned_to_operator =>tr_max_id)
					end  
			 end
	end
	

  # POST /tickets
  # POST /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)
    respond_to do |format|
      if @ticket.save
        format.html { redirect_to @ticket, notice: 'Ticket was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ticket }
      else
        format.html { render action: 'new' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
		end
  end

  # PATCH/PUT /tickets/1
  # PATCH/PUT /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to @ticket, notice: 'Ticket was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end	
			set_wp(params[:id])	
			if params[:set_auto] == "AutoAssign IT"
				auto_assign(params[:id])
			end
    end
  end

  # DELETE /tickets/1
  # DELETE /tickets/1.json
  def destroy
    @ticket.destroy
    respond_to do |format|
      format.html { redirect_to tickets_url }
      format.json { head :no_content }
    end
  end

  
  def count
	 @tot =	Ticket.count
	end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end
    	

    # Never trust parameters from the scary internet, only allow the white list through.
    def ticket_params
      params.require(:ticket).permit(:user_post,
									:user_id,
									:data_post,
									:subject,
									:obs,
									:status,					
									:department_id,
									:resolved,
									:working_progress_by,
									:working_progress_data,
									:resolved_by_operator,
									:resolved_data,
									:priority,
									:asigned_to_operator)
    end

end
