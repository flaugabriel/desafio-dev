class StoreFinder
  def self.find_by_cpf(cpf)
    Store.find_by(cpf: cpf)
  end
end