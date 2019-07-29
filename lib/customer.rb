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

  def new_meal(waiter, total, tip=0)
    Meal.new(waiter, self, total, tip)
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

  def best_tipper
    best_tipped_meal = meals.max do |meal_a, meal_b|
      meal_a.tip <=> meal_b.tip
    end
    best_tipped_meal.waiter
  end
end