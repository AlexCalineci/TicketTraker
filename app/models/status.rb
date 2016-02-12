class Status < ActiveRecord::Base
		attr_accessible :code,
										:description
    has_many :tickets
end
