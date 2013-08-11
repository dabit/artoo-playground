require 'artoo'
require 'csv'

connection :leapmotion, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leapmotion, :driver => :leapmotion

work do
  on leapmotion, :open => :on_open
  on leapmotion, :frame => :on_frame
  on leapmotion, :close => :on_close
  on leapmotion, :swipe_left => :on_swipe_left
end

def on_open(*args)
  puts args
end

def on_frame(*args)
  frame = args[1]
  pointables = frame.pointables
  gestures = frame.gestures
  unless gestures.empty?
    gesture = gestures.first
    if gesture.is_a? Artoo::Drivers::Leapmotion::Gesture::Swipe
      gesture = gestures.first
      if gesture.state == "stop"
        puts gesture.startPosition.inspect
        puts gesture.position.inspect
        puts gesture.direction.inspect
        puts gesture.type.inspect
        puts gesture.state.inspect
      end
    end
  end
end

def on_close(*args)
  puts args
end

def on_swipe_left(*args)
  #puts "Swipe Left"
end
