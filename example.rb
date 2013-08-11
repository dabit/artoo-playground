require 'bundler'

Bundler.setup

require 'artoo'
require 'pry'

connection :sphero, :adaptor => :sphero, :port => '/dev/tty.Sphero-ORB-RN-SPP'
device :sphero, :driver => :sphero

work do
  every(1.seconds) do
    puts "New Color... "
    #degree = 180
    #degree = (degree == 180 ? 360 : 180)
    sphero.set_color(rand(255), rand(255), rand(255))
    #pry.binding
    #puts "Rolling #{degree} degrees"
    #sphero.roll(90, degree)
  end
end
