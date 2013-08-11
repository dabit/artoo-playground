require 'artoo'
require 'csv'

FILE_NAME = 'data.txt'
File.unlink FILE_NAME if File.exists? FILE_NAME

connection :leapmotion, :adaptor => :leapmotion, :port => '127.0.0.1:6437'
device :leapmotion, :driver => :leapmotion

work do
  on leapmotion, :frame => :on_frame
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
        #debug(gesture)
      end
    end
  end

  pointables.each do |pointable|
    write_pointable_csv(pointable)
  end
end

def debug(gesture)
  puts gesture.startPosition.inspect
  puts gesture.position.inspect
  puts gesture.direction.inspect
  puts gesture.type.inspect
  puts gesture.state.inspect
end

def write_pointable_csv(pointable)
  CSV.open FILE_NAME, 'a+' do |csv|
    csv << pointable.stabilizedTipPosition
  end
end
