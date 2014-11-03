require "restaurant"
require "support/string_extend"

class Guide
	class Config
		@@actions = ["list", "find", "add", "quit", "exit"]
		
		def self.actions
			return @@actions
		end
	end

	def initialize (path=nil)
		Restaurant.filepath=path
		print "Loading data... "
		if Restaurant.file_usable?
			puts "found!"
		elsif
			Restaurant.create_file
			puts "created!"
		else
			puts "failed!"
			exit!
		end
	end
	
	def launch!
		system("clear")
		
		intro

		result = nil

		until result == :quit
			action, args = get_action
			res = do_action(action, args)
			break if res == :quit
		end

		conclusion
	end
	
	def get_action
		action = nil
	
		until Guide::Config.actions.include?(action)
			puts "Actions: " + Guide::Config.actions.join(", ") if action 
			print "> "
			user_response = gets.chomp
			args = user_response.downcase.strip.split(" ")
			action = args.shift
		end
		return action, args	
	end
		
	def do_action(action, args=[])
		case action
		when "list"
			list
		when "find"
			keyword = args.shift
			find(keyword)
		when "add"
			add
		when "quit"
			return :quit
		when "exit"
			return :quit
		else
			puts "Unknown command..."
		end
	end
	
	def find(keyword="")
		if keyword
			restaurants = Restaurant.saved_restaurants
			found = restaurants.select do |rest|
				rest.name.downcase.include?(keyword.downcase) ||
					rest.cuisine.downcase.include?(keyword.downcase) ||
						rest.price.to_i <= keyword.to_i
				end
				output_restaurant_table(found)
		else
			puts "Example: find mexican"
		end
	end
	
	def add
		puts "New restaurant..."
		
		restaurant = Restaurant.build_using_questions
		
		if restaurant.save
			puts "Saved!"
		else
			puts "Error occured saving restaurant!"
		end
	end
	
	def list
		output_action_header ("Saved restautrants")

		output_restaurant_table(Restaurant.saved_restaurants)
	end
	
	def intro
		output_action_header("Welcome to Ruby Restaurants (RRest)")
		output_action_header("the place to find things you love")
	end
	
	def conclusion
		output_action_header("See you soon again!")
	end
	
	private
	
	def output_action_header(text)
		puts text.upcase.center(64)
	end
	
	def output_restaurant_table(r=[])
		print " " + "Name".ljust(30)
		print " " + "Cuisine".ljust(20)
		print " " + "Price".rjust(10) + "\n"
		puts "-" * 64
		
		r.each do |rest|
			line = " " << rest.name.titleize.ljust(30)
			line << " " << rest.cuisine.titleize.ljust(20)
			line << " " << rest.formatted_price.rjust(10)
			puts line
		end
		
		puts "No restaurants here..." if r.empty?
		puts "-" * 64
	end
end