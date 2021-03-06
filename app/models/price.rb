class Price
  include Mongoid::Document
  include Mongoid::Timestamps
  include Rails.application.routes.url_helpers
  field :location, type: String
  field :sale, type: String
  field :sale_percentage, type: String
  field :sale_expiration, type: Integer
  field :price, type:Integer
  has_and_belongs_to_many :confirmations , class_name: "User", inverse_of: :confirms
  has_and_belongs_to_many :disconfirmations , class_name: "User", inverse_of: :disconfirms
  belongs_to :user, dependent: :delete, validate: false, inverse_of: :prices
  belongs_to :product, dependent: :delete, validate: false
  validates :price,  numericality: {greater_than: 0}

  def confirm!(user)
    if self.user != user
    	if !self.confirmations.include?(user)
    		if self.disconfirmations.include?(user)
      			self.disconfirmations.delete user
      		end
      		self.confirmations.push user
      		"price confirmed"
      	else
      		self.confirmations.delete user
      		"price confirmation removed"
      	end
    else
    	nil
    end

  end

  def disconfirm!(user)
    if self.user != user
    	if !self.disconfirmations.include?(user)
    		if self.confirmations.include?(user)
      			self.confirmations.delete user
      		end
      		self.disconfirmations << user
      		"price disconfirmed"
      	else
      		self.disconfirmations.delete user
      		"price disconfirmation removed"
      	end
    else
      nil
    end
  end
end
