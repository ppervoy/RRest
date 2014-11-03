class Restaurant
	@@filepath=nil
	
	def self.filepath=(path=nil)
		@@filepath=path
	end
	
	attr_accessor :name, :cuisine, :price
	
	def self.file_usable?
		return false unless @@filepath
		return false unless File.exists?(@@filepath)
		return false unless File.readable?(@@filepath)
		return false unless File.writable?(@@filepath)
		return true
	end
	
	def self.create_file
		File.open(@@filepath, "w")
		return file_usable?
	end
	
	def self.saved_restaurants
	end
	
	def initialize(args={})
		@name 		= args[:name] 		|| ""
		@cuisine 	= args[:cuisine] 	|| ""
		@price 		= args[:price] 		|| ""
	end
	
	def self.build_using_questions
		args={}
		
		print "  Restaurant name: "
		args[:name] = gets.chomp.strip
	
		print "  Cuisine type: "
		args[:cuisine] = gets.chomp.strip
	
		print "  Average check: "
		args[:price] = gets.chomp.strip
		
		return self.new(args)
	end
	
	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath, "a") do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}"
		end
		return true
	end
end