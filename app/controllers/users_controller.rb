class UsersController < ApplicationController
	before_action :set_user, only: [ :edit, :update, :destroy]  
	
	def index
		@users = User.all
  end

  def show
  end

	
  def edit
  end
	

	def user_departments	
	end

	def posted_by	 
	end
	
	#gets the user department ID
	def get_userDept(id)
		@user_dept = Department.where(["id = ?",id])
	end

	def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User Deparment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

	  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    

	  def user_params
      params.require(:user).permit(:username,
									:id,						
									:department_id)
    end

end
