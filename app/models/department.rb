class Department < ActiveRecord::Base
	attr_accessible :code,
									:description
	has_many :users
  has_many :tickets
end
