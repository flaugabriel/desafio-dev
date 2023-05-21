class Api::V1::DealSerializer < ActiveModel::Serializer
  attributes :id, :type_transaction, :description, :nature, :signal
end
