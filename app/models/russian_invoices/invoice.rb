class RussianInvoices::Invoice < RussianInvoices::BaseModel

  attr_accessor :from_date, :recipient_bank_name, :recipient_bank_bik,
    :recipient_bank_invoice_number, :recipient_invoice_number, :recipient_inn,
    :recipient_kpp, :recipient_name, :invoice_number, :provider, :customer,
    :goods, :nds, :stamp, :chief_name, :chief_signature, :accountant_name,
    :accountant_signature

  validates_presence_of :from_date, :recipient_bank_name, :recipient_bank_bik,
    :recipient_bank_invoice_number, :recipient_invoice_number, :recipient_inn,
    :recipient_kpp, :recipient_name, :invoice_number, :provider, :customer,
    :goods, :chief_name, :accountant_name

  def total_summ_to_pay
    if self.nds.present?
      ((self.total_summ * self.nds) + self.total_summ).round
    else
      self.total_summ
    end
  end

  def total_summ
    goods.sum{ |good| good[:count] * good[:price] }
  end

  def total_count
    goods.sum{ |good| good[:count] }
  end

  def nds_summ
    (total_summ * nds / 100)
  end
end
