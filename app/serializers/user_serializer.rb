class UserSerializer < ActiveModel::Serializer
  attributes :id, :avatar, :username, :email, :prices, :points
end
