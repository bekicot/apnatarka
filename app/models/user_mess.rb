class UserMess < ApplicationRecord
	belongs_to :mess_item
	belongs_to :mess_request
end
