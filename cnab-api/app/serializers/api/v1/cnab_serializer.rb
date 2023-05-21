class Api::V1::CnabSerializer < ActiveModel::Serializer
  attributes :id, :type_cnabs, :date_occurrence, :value, :card, :hours

  has_one :deal
  has_one :user
  has_one :store
end
