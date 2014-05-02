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
	end
	
	def draw
		#PUT WHITE BACKGROUND HERE
		#USE QUAD DRAW FROM GOSU
	end
end

class GameWindow < Gosu::Window

	def initialize
		super(768,1024,false)
		self.caption = "Working Title"
		@player = Player.new(self)
	end
	
	def update
		
	end
	
	def draw
		@player.draw
	end
end

window = GameWindow.new
window.show