#<working title>


#By Jack Doherty


#Copyright Stuff


require "rubygems"
require "gosu"

class Player

	def initialize(window)
		@x = 192
		@y = 512
		@vy = 0
		@image = Gosu::Image.new(window, "resources/images/player.png", false)
	end
	
	def move
		@y += @vy
		@vy += 0.9
		if @y > 946
			@y = 946
		end
	end
	
	def jump
		@vy = -15
	end
	
	def draw
		@image.draw(@x, @y, 2)
	end
end

class Background
	attr_reader :images
	def initialize(window)
		@width = 768
		@height = 1024
		@images = []
		(1..54).each do |n|
			@images.push Gosu::Image.new(window, "resources/images/background/#{n.to_i}.png", false)
		end
		@imageIndex = 0
	end
	
	def draw
		@images[@imageIndex].draw(0,0,1)
		@imageIndex += 1
		if @imageIndex == 53
			@imageIndex = 0
		end
	end
end

class GameWindow < Gosu::Window

	def initialize
		super(768,1024,false)
		self.caption = "Working Title"
		@player = Player.new(self)
		@background = Background.new(self)
		@initLockout = true
	end
	
	def update
		if @initLockout == false
			@player.move
		else
			if button_down?(Gosu::KbSpace)
				@initLockout = false
			end
		end
	end
	
	def draw
		@player.draw
		@background.draw
		if @initLockout == true
			bgC = Gosu::Color.argb(0x60000000)
			self.draw_quad(0, 0, bgC, 768, 0, bgC, 768, 1024, bgC, 0, 1024, bgC, 9)
		end
	end
	
	def button_down(id)
		if id == Gosu::KbSpace
			@player.jump
		end
	end
end

window = GameWindow.new
window.show