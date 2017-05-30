class Price
  include Mongoid::Document
  field :date, type: Date
  field :confirm, type: Integer
  field :disconfrim, type: Integer
  field :location, type: String
  field :image, type: String
  field :price, type:Integer
  #belongs_to :user, dependent: :delete, validate: false
  belongs_to :product, dependent: :delete, validate: false
end
