Buyer.destroy_all
Dealer.destroy_all
Manufacturer.destroy_all
Vehicle.destroy_all


tom = Buyer.create(name: "Tom")
john = Buyer.create(name: "John")
steve = Buyer.create(name: "Steve")
penn = Buyer.create(name: "Penn")
matine = Buyer.create(name: "Matine")
solomon = Buyer.create(name: "Solomon")


enterprise = Dealer.create(name: "Enterprise", account_balance: 2781425)
penske = Dealer.create(name: "Penske", account_balance: 4087295)
carvana = Dealer.create(name: "Carvana", account_balance: 3142863)
car_max = Dealer.create(name: "Car Max", account_balance: 1445239)

toyota = Manufacturer.create(name: "Toyota Motor Corporation")
honda = Manufacturer.create(name: "Honda Motor Company, Ltd")
nissan = Manufacturer.create(name: "Nissan Motor Company, Ltd")

15.times do
    Vehicle.create(model: Faker::Vehicle.model(make_of_model: 'Honda'), make: "Honda", owner: honda, milage: Faker::Vehicle.mileage(min: 300, max: 500), year: Faker::Number.within(range: 2016..2020), price: Faker::Number.within(range: 9000..25000), model_number: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase)
end

15.times do
    Vehicle.create(model: Faker::Vehicle.model(make_of_model: 'Nissan'), make: "Nissan", owner: nissan, milage: Faker::Vehicle.mileage(min: 500, max: 600), year: Faker::Number.within(range: 2017..2020), price: Faker::Number.within(range: 8000..23000), model_number: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase)
end

15.times do
    Vehicle.create(model: Faker::Vehicle.model(make_of_model: 'Toyota'), make: "Toyota", owner: toyota, milage: Faker::Vehicle.mileage(min: 100, max: 300), year: Faker::Number.within(range: 2018..2020), price: Faker::Number.within(range: 9500..34000), model_number: Faker::Alphanumeric.alphanumeric(number: 6, min_alpha: 3, min_numeric: 3).upcase)
end

