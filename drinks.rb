class Drinks

  attr_accessor :name, :type, :price, :alcohol_content

  def initialize(name, type, price, alcohol_content)
    @name = name
    @price = price
    @type = type
    @alcohol_content = alcohol_content
  end

end
