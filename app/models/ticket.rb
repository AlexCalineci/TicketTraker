class Ticket < ActiveRecord::Base
	
	belongs_to :user
	belongs_to :department	
	has_many	 :comments ,:dependent => :delete_all
  belongs_to :statuses
  accepts_nested_attributes_for :comments
	attr_accessible :user_post,
										:id,
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
										:asigned_to_operator
   
   validates :priority, :inclusion => { :in => ['High','Low','Urgent','Immediate']}
   validates :user_id, presence: true
	 validates :subject, presence: true

	 before_save(on: :asigned_to_operator) do
     validates_presence_of :asigned_to_operator
 	 end
		
	def self.search(search)
		search_condition = "%" + search + "%"
		where(['subject LIKE ?  OR status like ? or id like ? or priority like ?', search_condition, search_condition,search_condition, search_condition])
	end

	def single(records)
		if records.nil? 
		 	records = 0
		elsif (!records.nil? and records.mb_chars.length == 0)
		  records = 0
		else 
			return records.first
		end
	end

end
