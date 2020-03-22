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

  def room_capacity_full?(room)
    if room.capacity <= room.customer_count
      return true
    else
      return false
    end
  end

  def customer_is_above_age?(customer)
    customer.age >= @age_limit
  end

  def customer_too_drunk?(customer)
    customer.drunkness > @drunkness_level
  end

  def add_customer_to_room(room, customer)
    return if !customer.enough_cash?(room)
    return if !customer_is_above_age?(customer)
    return if room_capacity_full?(room)
    return if customer_too_drunk?(customer)
    room.add_customer(customer)
    customer.pay(room.price)
    room.add_money_to_till(room.price)
    room.increase_customer_spending(room.price)
  end

  def add_item_to_stock(item)
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
    @stock.keys.reduce(0) {|total, item| total + item.price * @stock[item]}
  end

  def stock_value_by_item(item)
    level = stock_level(item)
    level * item.price
  end

  def add_item_to_customer(customer, item)
    customer.tray.push(item)
  end

  def serve_food_to_customer(customer, food)
    return if !customer.enough_cash?(food)
    if @stock[food] > 0
      customer.pay(food.price)
      add_item_to_customer(customer, food)
      @stock[food] -= 1
      add_money_to_till(food.price)
      increase_customer_spending(food.price)
    end
  end

  def serve_drink_to_customer(customer, drink)
    return if !customer.enough_cash?(drink)
    return if !customer_is_above_age?(customer)
    return if customer_too_drunk?(customer)
    if @stock[drink] > 0
      customer.pay(drink.price)
      add_item_to_customer(customer, drink)
      @stock[drink] -= 1
      add_money_to_till(drink.price)
      increase_customer_spending(drink.price)
    end
  end

  def increase_customer_spending(amount)
    @customer_spending += amount
  end

  def decrease_customer_spending(amount)
    @customer_spending -= amount
  end

  def bar_tab_has_credit?(room, item)
    room.tab >= item.price
  end

  def if_using_bar_tab_food(room, customer, food)
    return if !bar_tab_has_credit?(room, food)
    if @stock[food] > 0
      add_item_to_customer(customer, food)
      @stock[food] -= 1
      room.tab -= food.price
    end
  end

  def if_using_bar_tab_drink(room, customer, drink)
    return if !bar_tab_has_credit?(room, drink)
    if @stock[drink] > 0
      add_item_to_customer(customer, drink)
      @stock[drink] -= 1
      room.tab -= drink.price
    end
  end

  def drink_promotion_50off(drink)
    drink.price * 0.5
  end

  def drink_happy_hour(customer, drink)
    return if !customer.enough_cash?(drink)
    return if !customer_is_above_age?(customer)
    return if customer_too_drunk?(customer)
    if @stock[drink] > 0
      customer.pay(drink_promotion_50off(drink))
      add_item_to_customer(customer, drink)
      @stock[drink] -= 1
      add_money_to_till(drink_promotion_50off(drink))
      increase_customer_spending(drink_promotion_50off(drink))
    end
  end

  def food_buy_1_get_1_free(customer, food)
    return if !customer.enough_cash?(food)
    if @stock[food] > 0
      customer.pay(food.price)
      add_item_to_customer(customer, food)
      add_item_to_customer(customer, food)
      @stock[food] -= 2
      add_money_to_till(food.price)
      increase_customer_spending(food.price)
    end
  end

  def customer_refund(customer, item)
    customer.wallet += item.price
    remove_money_from_till(item.price)
    decrease_customer_spending(item.price)
  end

end
