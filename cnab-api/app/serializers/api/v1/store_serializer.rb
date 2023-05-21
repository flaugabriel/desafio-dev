class Api::V1::StoreSerializer < ActiveModel::Serializer
  attributes :id, :store_owner, :cpf, :store_name, :balance_total
end
