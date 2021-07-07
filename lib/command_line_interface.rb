require 'rainbow'

def run
    system("clear")
    greet
    get_a_dealer
    intro
    input = ""
    
    while input != "10"
        input = print_menu
        menu_nav(input)
    end
end
    

def loading_bar
    bar = TTY::ProgressBar.new("Please wait, completing transaction [:bar]", total: 40)
    40.times do
        sleep(0.1)
        bar.advance(1)
    end
end


def greet
    @time = Time.new
    if @time.hour >= 5 && @time.hour < 12 && @time.min < 60
        puts         Rainbow("\n\n\n                  *** Good morning ***\n\n").green.bold
    elsif @time.hour >= 12 && @time.hour < 18 && @time.min < 60
        puts         Rainbow("\n\n\n                  *** Good afternoon ***\n\n").green.bold
    elsif @time.hour >= 18 && @time.hour < 24 && @time.min < 60 || @time.hour >= 0 && @time.hour < 5 && @time.min < 60
        puts         Rainbow("\n\n\n                  *** Good evening ***\n\n").green.bold
    end

          puts"  ░█──░█ ░█▀▀▀ ░█─── ░█▀▀█ ░█▀▀▀█ ░█▀▄▀█ ░█▀▀▀ 　 ▀▀█▀▀ ░█▀▀▀█ "
          puts"  ░█░█░█ ░█▀▀▀ ░█─── ░█─── ░█──░█ ░█░█░█ ░█▀▀▀ 　 ─░█── ░█──░█ "
          puts"  ░█▄▀▄█ ░█▄▄▄ ░█▄▄█ ░█▄▄█ ░█▄▄▄█ ░█──░█ ░█▄▄▄ 　 ─░█── ░█▄▄▄█ \n\n"
            
        puts"   ░█▀▀█ ─█▀▀█ ░█▀▀█ ── ░█▀▄▀█ ─█▀▀█ ░█▀▀█ ░█─▄▀ ░█▀▀▀ ▀▀█▀▀ "
        puts"   ░█─── ░█▄▄█ ░█▄▄▀ ▀▀ ░█░█░█ ░█▄▄█ ░█▄▄▀ ░█▀▄─ ░█▀▀▀ ─░█── "
        puts"   ░█▄▄█ ░█─░█ ░█─░█ ── ░█──░█ ░█─░█ ░█─░█ ░█─░█ ░█▄▄▄ ─░█── \n\n"
                    
           puts"                     ─█▀▀█ ░█▀▀█ ░█▀▀█ "
           puts"                     ░█▄▄█ ░█▄▄█ ░█▄▄█ "
           puts"                     ░█─░█ ░█─── ░█───  "

end



def account_login
    puts "\n\nLog in to your account: \n\n"
    username = gets.chomp
end



def get_a_dealer
    @this_dealer = Dealer.find_or_create_by(name: account_login)
    puts "\n\nWelcome #{@this_dealer.name}!"
    @this_dealer
end


def intro
    puts "\n\nThis App allows your company to keep track of activities."
    puts ""
end


def print_menu
    puts ""
    menu = Artii::Base.new
    puts Rainbow(menu.asciify("Menu - choose an option")).green
    puts ""
    puts ("             1. ") + "Buy a car from manufacturer"
    puts ("             2. ") + "Sell a car to a buyer"
    puts ("             3. ") + "Check inventory"
    puts ("             4. ") + "See vehicle information"
    puts ("             5. ") + "Check account balance"
    puts ("             6. ") + "Current stock and total stock cost"
    puts ("             7. ") + "View oldest vehicle"
    puts ("             8. ") + "Change vehicle price"
    puts ("             9. ") + "All suppliers(manufacturers)"
    puts ("             10. ") + "Exit"
    puts ""
    input = gets.chomp
end

# Helper methods for buy a car from manufacturer

def select_manufacturer
    puts "\nSelect a manufacturer: "
    puts Manufacturer.manufacturer_list
    @manufacturer_index = gets.chomp.to_i
    if !@manufacturer_index.between?(1, Manufacturer.all.count)
        puts Rainbow("Option does not exist, please select again!").red.bold
        select_manufacturer
    end
end

def get_a_manufacturer
    @this_manufacturer = Manufacturer.all[@manufacturer_index - 1]
end

def select_vehicle
    puts "\nChoose vehicle number:"
    puts @this_manufacturer.manufacturer_inventory_list
    @man_vehicle_index = gets.chomp.to_i
    if !@man_vehicle_index.between?(1, @this_manufacturer.vehicles.count)
        puts Rainbow("Option does not exist, please select again!").red.bold
        select_vehicle
    end
end

def get_vehicle_from_manufacturer
    @this_vehicle = @this_manufacturer.vehicles[@man_vehicle_index - 1]
end


# Helper methods for sell a vehicle to buyer

def enter_buyer
    puts "\n\nEnter a buyer name:"
    buyer_name = gets.chomp
end

def get_a_buyer
    @this_buyer = Buyer.find_or_create_by(name: enter_buyer.capitalize)
end

def select_vehicle_from_dealer
    puts "\nChoose a vehicle\n"
    puts @this_dealer.inventory_list
    @dealer_vehicle_index = gets.chomp.to_i
    if !@dealer_vehicle_index.between?(1, @this_dealer.vehicles.count)
        puts Rainbow("Option does not exist, please select again!").red.bold
        select_vehicle_from_dealer
    end
end

def get_vehicle_from_dealer
    @this_vehicle = @this_dealer.vehicles[@dealer_vehicle_index - 1]
end

#Change vehicle price helper method
def choose_vehicle_price
    puts "Enter new price"
    @new_price = gets.chomp.to_i
    if !@new_price.is_a? Numeric
        puts Rainbow("This value is invalid. Please try again.").red.bold
        choose_vehicle_price
    end
end

def change_vehicle_price(vehicle, price)
    vehicle.price = price
    puts "* The #{vehicle.print_vehicle_info} with model number '#{@this_vehicle.model_number}' price is now $#{price}."
end

def menu_nav(input)
      case input

        when "1"
            system("clear")
            select_manufacturer
            get_a_manufacturer
            select_vehicle
            get_vehicle_from_manufacturer
            @this_dealer.buy_vehicle_from_manufacturer(@this_vehicle)
            system("clear")
            loading_bar
            puts Rainbow("\nYour purchase of #{@this_vehicle.year} #{@this_vehicle.make} #{@this_vehicle.model} is complete!").green.bold
            
        when "2"
            if @this_dealer.vehicles.count > 0
                get_a_buyer
                select_vehicle_from_dealer
                get_vehicle_from_dealer
                @this_dealer.sell_vehicle_to_buyer(@this_vehicle, @this_buyer)
                system("clear")
                loading_bar
                puts "\nBuyer name: #{@this_buyer.name}"
                puts "Vehicle specifications: year - #{@this_vehicle.year}, make - #{@this_vehicle.make}, model number - #{@this_vehicle.model}"
                puts "Selling price: #{@this_vehicle.dealer_selling_price}\n"
            else
                puts Rainbow("\nYou don't have a vehicle to sell, please stock a vehicle from your suppliers!").red
            end
        when "3"
            @this_dealer.inventory_list
        when "4"
            if @this_dealer.vehicles.count > 0
                select_vehicle_from_dealer
                get_vehicle_from_dealer
                @this_vehicle.all_info
            else
                puts Rainbow("You don't have vehicle in stock, please buy vehicle(s) from your suppliers!").red
            end
        when "5"
            puts "Your current balance is $#{@this_dealer.account_balance}"
        when "6"
            puts "Total number of vehicles: #{@this_dealer.inventory_count}"
            puts "Total cost of current stock: $ #{@this_dealer.stock_account_balance}"
        when "7"
            if @this_dealer.vehicles.count > 0
                puts @this_dealer.dealer_oldest_vehicle
            else
                puts Rainbow("\nYou don't have any vehicles, please stock a vehicle from your suppliers!").red
            end
        when "8"
            if @this_dealer.vehicles.count > 0
                select_vehicle_from_dealer
                get_vehicle_from_dealer
                puts "#{@this_vehicle.all_info}"
                choose_vehicle_price
                change_vehicle_price(@this_vehicle, @new_price)
            else
                puts Rainbow("\nYou don't have a vehicle to change its price, please stock a vehicle from your suppliers!").red
            end
            
        when "9"
            puts "List of supplier(s):"
            Manufacturer.manufacturer_list
        when "10"
            system("clear")
            goodbye = Artii::Base.new
            puts Rainbow(goodbye.asciify("Good bye  !")).red
        else
          puts Rainbow("That option does not exist. Please try again!").yellow.bold
      end
end