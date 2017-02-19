require 'csv'
require 'io/console'
require 'byebug'

require_relative 'Car'
require_relative 'Parking'

parking = Parking.new

while true
  # puts "Input: "
  # input = gets.chomp
  input = gets
  break if input.nil? # to detect end of file
  input ||= ''
  input.chomp! 
  break if input == "exit"
  parking.process_input(input.split(" "))
end
