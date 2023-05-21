class CnabCreator
  def self.create_cnab(type_cnabs, date_occurrence, new_total, card, hours, deal, store_id, user_id)
    Cnab.new(
      type_cnabs: type_cnabs,
      date_occurrence: date_occurrence,
      value: new_total,
      card: card,
      hours: hours,
      deal_id: type_cnabs,
      store_id: store_id,
      user_id: user_id
    )
  end
end