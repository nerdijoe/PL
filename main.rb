require 'csv'
require 'io/console'
require 'byebug'

class Car
  attr_reader :reg_num, :colour
  def initialize(**input)
    @reg_num = input.fetch(:reg_num)
    @colour = input.fetch(:colour)
  end
end


class Parking
  attr_reader :slots

  @@num_cars = 0
  def initialize(**input)
    # @num_slots = input.fetch(:num_slots)
    # @file = input.fetch(:file)
    @slots = nil
  end

  def process_input(argv_arr)
    action = argv_arr[0]

    case action
      when "create_parking_lot"
        return @slots if @slots

        # get the total number of slots
        num_slots = argv_arr[1].to_i
        @slots = Array.new(num_slots)
        byebug

      when "park"
        # have to assign to the nearest to the entry
        if @@num_cars == @slots.size
          puts "Sorry, parking lot is full"
        else
          @slots.each_with_index do |slot, i|
            if !slot
              @slots[i] = Car.new(reg_num: argv_arr[1], colour: argv_arr[2])
              @@num_cars += 1
              byebug
              break
            end
          end
        end # end of if @num_cars == @slots.size

      when "leave"
        puts "leave it"
        if @slots.size == 0
          puts "Sorry, the parking lot is empty"
        else
          index = argv_arr[1].to_i - 1
          @slots[index] = nil
          byebug
        end


      when "status"
        if @slots.size == 0
          puts "Parking lot is empty"
        else
          puts "Slot No.    Registration No   Colour"
          @slots.each_with_index do |slot, i|
            puts "#{i+1}         #{slot.reg_num}      #{slot.colour}" if slot
          end
        end

      when "registration_numbers_for_cars_with_colour"

      when "slot_numbers_for_cars_with_colour"

      when "slot_number_for_registration_number"

    end # end of case action

  end

end



parking = Parking.new

argv_arr = ["create_parking_lot", "6"]

parking.process_input(argv_arr)

while true
  puts "Input: "
  input = gets.chomp

  parking.process_input(input.split(" "))
end

# figure out how to start the program
# when user type create_parking_lot
# user can already park a car
