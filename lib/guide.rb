require "restaurant"

class Guide
	def initialize (path = nil)
		Restaurant.filepath = path
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
		# action loop
		#  prompt
		#  do
		# repeat until qut
		conclusion
	end
	
	def intro
		puts "Welcome to Ruby Restaurants (RRest)"
		puts "the place to find things you love"
	end
	
	def conclusion
		puts "See you soon again!"
	end
end