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

  def customer_has_cash?(customer, item)
    customer.wallet >= item.price
  end

  def customer_is_above_age?(customer)
    customer.age >= @age_limit
  end

  def customer_too_drunk?(customer)
    customer.drunkness > @drunkness_level
  end

  def add_item(item)
    if @stock.include?(item)
      @stock[item] += 1
    else
      @stock[item] = 1
    end
  end

  def stock_level(item)
    return @stock[item]
  end

  def stock_value()
    total = 0
    for item in @stock.keys
      total += (item.price * @stock[item])
    end
    return total
  end

  def serve_food_to_customer(customer, food)
    return if !customer_has_cash?(customer, food)
    if @stock[food] > 0
      customer.pay(food.price)
      customer.consume_food(food)
      @stock[food] -= 1
      add_money_to_till(food.price)
    end
  end

  def serve_drink_to_customer(customer, drink)
    return if !customer_has_cash?(customer, drink)
    return if !customer_is_above_age?(customer)
    return if customer_too_drunk?(customer)
    if @stock[drink] > 0
      customer.pay(drink.price)
      customer.consume_drink(drink)
      @stock[drink] -= 1
      add_money_to_till(drink.price)
    end
  end

end
