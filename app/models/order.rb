class Order < ApplicationRecord
	serialize :stripe_payload
	validates_uniqueness_of :uid
	before_validation :set_uid

	def set_uid
		return if !self.stripe_payload
		self.uid = stripe_payload.id
	end

end
