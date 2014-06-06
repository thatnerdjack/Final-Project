#<working title>


#By Jack Doherty


#Copyright Stuff


require "rubygems"
require "gosu"

class Player

	def initialize(window)
		@x = 230
		@y = 480
		@vy = 0
		@image = Gosu::Image.new(window, "resources/images/player.png", false)
	end
	
	def move
		@y += @vy
		@vy += 1
		if @y > 946
			@y = 946
		end
	end
	
	def jump
		@vy = -15
	end
	
	def draw
		@image.draw(@x, @y, 3)
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

class Score

	def initialize(window)
		@value = 0
		@x = 333
		@y = 0
		@fontScore = Gosu::Font.new(window, "resources/fonts/font.ttf", 144)
	end
	
	def draw
		@fontScore.draw("#{@value}", @x, @y, 8)
	end
end

class Pipe

	attr_reader :x, :y, :width, :height

	def initialize(window)
		@x = 968
		@yBottom = nil
		@yTop = nil
		yPos
		@image = Gosu::Image.new(window, "resources/images/pipe.png", false)
		@width = 200
		@height = 1100
		@speed = 3
	end
	
	def draw
		@image.draw_rot(@x - @width/2, @yBottom + @height/2, 2, 0)
		@image.draw_rot(@x - @width/2, @yTop - @height/2, 2, 180)
	end
	
	def move
		@x -= @speed
	end
	
	def yPos
		@yID = rand(3) + 1
		if @yID == 1
			@yBottom = 532
			@yTop = 332
		elsif @yID == 2
			@yBottom = 332
			@yTop = 132
		elsif @yID == 3
			@yBottom = 732
			@yTop = 532
		end
	end
end

class GameWindow < Gosu::Window

	def initialize
		super(768,1024,false)
		self.caption = "Working Title"
		@player = Player.new(self)
		@background = Background.new(self)
		@score = Score.new(self)
		@initLockout = true
		@pipes = []
		@pipes.push Pipe.new(self)
		@pipeTimer = 0
	end
	
	def update
		if @initLockout == false
			@player.move
			@pipeTimer += 1
			if @pipeTimer == 149
				@pipes.push Pipe.new(self)
				@pipeTimer = 0
			end
			@pipes.each do |pipe|
				pipe.move
			end
		else
			if button_down?(Gosu::KbSpace)
				@initLockout = false
			end #button down if
		end #lockout if
	end #def if
	
	def draw
		@player.draw
		@background.draw
		@score.draw
		@pipes.each do |pipe|
			pipe.draw
		end
		if @initLockout == true
			bgC = Gosu::Color.argb(0x60000000)
			fontTapTap = Gosu::Font.new(self, "resources/fonts/font.ttf", 60)
			fontGetReady = Gosu::Font.new(self, "resources/fonts/font.ttf", 96)
			self.draw_quad(0, 0, bgC, 768, 0, bgC, 768, 1024, bgC, 0, 1024, bgC, 9)
			fontTapTap.draw("Tap>>•<<Tap", 225, 612, 10)
			fontGetReady.draw("Get Ready!", 165, 290, 10)
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