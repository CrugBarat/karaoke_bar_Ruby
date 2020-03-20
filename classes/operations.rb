class Operations

  def add_money_to_till(amount)
    @till += amount
  end

  def remove_money_from_till(amount)
    @till -= amount
  end

  def customer_count()
    @customers_array.size()
  end

  def add_customer(customer)
    @customers_array.push(customer)
  end

  def remove_customer(customer)
    @customers_array.delete(customer)
  end

  def clear_room()
    @customers_array.clear()
  end

  def customer_credit_check?(customer, item)
    item_price = item.price
    customer.wallet >= item_price
  end

end
