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
	
	def save
		return false unless Restaurant.file_usable?
		File.open(@@filepath, "a") do |file|
			file.puts "#{[@name, @cuisine, @price].join("\t")}"
		end
		return true
	end
end