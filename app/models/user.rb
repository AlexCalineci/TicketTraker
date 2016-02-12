class User < ActiveRecord::Base
	has_many :tickets, dependent: :destroy
	has_many :comments, dependent: :destroy
	belongs_to :department
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable
  # Setup accessible (or protected) attributes for your model
 attr_accessible:email, 
								:password, 
								:password_confirmation, 
								:remember_me, 
								:username, 
								:provider, 
								:uid,
								:department_id, 
								:avatar
  # METHODS ---------------------------------------------
  def self.from_omniauth(auth)
    if user = User.find_by_email(auth.info.email)
     user.provider = auth.provider
      user.uid = auth.uid
      user.username  = auth.info.name 
      user
    else
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.email = auth.info.email
      end
    end
  end
  

	
  
  
end
