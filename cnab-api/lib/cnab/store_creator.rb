class StoreCreator
  def self.create_store(cpf, store_owner, store_name, new_total)
    Store.create!(
      cpf: cpf,
      store_owner: store_owner.strip,
      store_name: store_name.strip,
      balance_total: new_total
    )
  end
end