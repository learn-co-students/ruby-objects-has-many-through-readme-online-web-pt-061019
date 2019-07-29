require_relative './lib/meal.rb'
require_relative './lib/waiter.rb'
require_relative './lib/customer.rb'
class Customer
  attr_accessor :name, :age

  @@all = []

  def initialize(name, age)
    @name = name
    @age = age
    @@all << self
  end

  def self.all
    @@all
  end

  def meals
    Meal.all.select do |meal|
      meal.customer == self
    end
  end

  def waiters
    meals.map do |meal|
      meal.waiter
    end
  end

  def new_meal(waiter, total, tip=0)
    Meal.new(waiter, self, total, tip)
  end

  def new_meal_20_percent(waiter, total)
    tip = total * 0.2
    Meal.new(waiter, self, total, tip)
  end

  def self.oldest_customer
    oldest_age = 0
    oldest_customer = nil
    self.all.each do |customer|
      if customer.age > oldest_age
        oldest_age = customer.age
        oldest_customer = customer
      end
    end
    oldest_customer
  end

end

sam = Customer.new("Sam", 27)
  pat = Waiter.new("Pat", 2)
  alex = Waiter.new("Alex", 5)
  sam.new_meal(pat, 50, 10) # A Customer creates a Meal, passing in a Waiter instance
  sam.new_meal(alex, 20, 3) # A Customer creates a Meal, passing in a Waiter instance
  pat.new_meal(sam, 30, 5) # A Waiter creates a Meal, passing in a Customer instance
  terrance = Customer.new("Terrance", 27)
