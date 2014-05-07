#<working title>


#By Jack Doherty


#Copyright Stuff


require "rubygems"
require "gosu"

class Player

	def initialize(window)
		@x = 192
		@y = 512
		@image = Gosu::Image.new(window, "resources/images/player.png", false)
	end
	
	def draw
		@image.draw(@x, @y, 2)
	end
end

class Background
	def initialize(window)
		@width = 768
		@height = 1024
		@images = []
		(1..18).each do |n|
			@images.push Gosu::Image.new(window, "/resources/images/background/#{n.to_i}.png", false)
		end #STOPPED HERE!
	end
	
	def draw
		@images.draw(0, 0, 1)
	end
end

class GameWindow < Gosu::Window

	def initialize
		super(768,1024,false)
		self.caption = "Working Title"
		@player = Player.new(self)
		@background = Background.new(self)
	end
	
	def update
		
	end
	
	def draw
		@player.draw
		@background.draw
	end
end

window = GameWindow.new
window.show