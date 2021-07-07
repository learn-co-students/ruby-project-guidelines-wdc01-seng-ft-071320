class Vehicle < ActiveRecord::Base
    belongs_to :owner, polymorphic: true

    def print_vehicle_info
        "#{self.year} #{self.make} #{self.model}"
    end

    def dealer_selling_price
        self.price = (1.2 * self.price).round(2)
    end

    def all_info
        puts "\nModel: #{self.model}"
        puts "Manufacturer: #{self.make}"
        puts "Year: #{self.year}"
        puts "Milage: #{self.milage}"
        puts "Price: #{self.price}"
        puts "Model Number: #{self.model_number}"
    end
end