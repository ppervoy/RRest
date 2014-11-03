require "restaurant"

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
		intro

		result = nil

		until result == :quit
			action = get_action
			res = do_action(action)
			break if res == :quit
		end

		conclusion
	end
	
	def get_action
		action = nil
	
		until Guide::Config.actions.include?(action)
			puts "Available actions: " + Guide::Config.actions.join(", ") if action 
			print "> "
			user_response = gets.chomp
			action = user_response.downcase.strip
		end
		return action	
	end
	
	def do_action(action)
		case action
		when "list"
			puts "Listing:"
		when "find"
			puts "Finding:"
		when "add"
			puts "Adding:"
		when "quit"
			return :quit
		when "exit"
			return :quit
		else
			puts "Unknown command..."
		end
	end
	
	def intro
		puts "Welcome to Ruby Restaurants (RRest)"
		puts "the place to find things you love"
	end
	
	def conclusion
		puts "See you soon again!"
	end
end