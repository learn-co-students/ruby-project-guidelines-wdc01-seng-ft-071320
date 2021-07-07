require "tty-prompt"

class Dealer < ActiveRecord::Base
    has_many :vehicles, as: :owner
    
    def initialize(attributes=nil)
        super(attributes)
        self.account_balance = 500000
    end
    
    def buy_vehicle_from_manufacturer(vehicle)
        vehicle.update(owner: self)
        #binding.pry
        self.account_balance -= vehicle.price
        self.vehicles << vehicle
        self.save
    end
    

    def sell_vehicle_to_buyer(vehicle, buyer)
        @sold_vehicles = []
        @sold_vehicles << vehicle
        @sold_vehicles.each {|vehicle| vehicle.save}
        vehicle.update(owner: buyer)
        self.account_balance += (1.2 * vehicle.price)
        self.vehicles.delete(vehicle)
        self.save
    end

    def inventory
        self.vehicles
    end

    def stock_account_balance
        self.inventory.map {|vehicle| vehicle.price}.sum
    end
    
    def inventory_count
        self.vehicles.count
    end
    
    def inventory_list
        if self.inventory_count > 0
            self.vehicles.map.with_index(1) {|vehicle, index| print "           #{index}. #{vehicle.make} #{vehicle.model} #{vehicle.year}\n"}
        else
            puts "You don't have vehicle in stock, please buy vehicle(s) from your suppliers!"
        end
    end
    
    def sold_vehicles
        @sold_vehicles
    end
    
    def sold_vehicles_list
        self.sold_vehicles.map.with_index(1) {|vehicle, index| print "#{index}. #{vehicle.year} #{vehicle.make} #{vehicle.model}\n"}
    end
    
    def old_car
        self.vehicles.min_by {|v| v.year}
    end
    
    def dealer_oldest_vehicle
        # old_car = self.vehicles.min_by {|v| v.year}
        "Year: #{old_car.year}, Make: #{old_car.make}, Model: #{old_car.model}, Current selling price: $ #{old_car.price}"
    end

    def most_sold_vehicle_by_model
        sold_vehicles.max_by{|vehicle| vehicle.model}
    end
    
end