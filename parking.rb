
class Parking
  attr_reader :slots

  def initialize(**input)
    # @num_slots = input.fetch(:num_slots)
    # @file = input.fetch(:file)
    @slots = nil
    @num_cars = 0
  end

  def num_cars
    @num_cars
  end

  def process_input(argv_arr)
    action = argv_arr[0]

    case action
      when "create_parking_lot"
        if @slots
          puts "Sorry, parking lot has been created with #{@slots.size} slots"
          return @slots
        else
          # get the total number of slots
          num_slots = argv_arr[1].to_i
          @slots = Array.new(num_slots)
          puts "Created a parking lot with #{num_slots} slots"
        end

      when "park"
        # park [car registration number] [colour]
        # have to assign to the nearest to the entry
        if @num_cars == @slots.size
          puts "Sorry, parking lot is full"
        else
          @slots.each_with_index do |slot, i|
            if !slot
              @slots[i] = Car.new(reg_num: argv_arr[1], colour: argv_arr[2])
              @num_cars += 1
              puts "Allocated slot number: #{i+1}"
              #break from the loop after the car has been assigned to nearest slot
              break
            end
          end
        end # end of if @num_cars == @slots.size

      when "leave"
        # leave [parking slot number]
        if @num_cars == 0
          puts "Sorry, the parking lot is empty"
        else
          index = argv_arr[1].to_i - 1
          @slots[index] = nil
          @num_cars -= 1
          puts "Slot number #{index + 1} is free"
        end

      when "status"
        # status
        if @num_cars == 0
          puts "Parking lot is empty"
        else
          puts "Slot No.    Registration No   Colour"
          @slots.each_with_index do |slot, i|
            puts "#{i+1}         #{slot.reg_num}      #{slot.colour}" if slot
          end
        end

      when "registration_numbers_for_cars_with_colour"
        if @num_cars == 0
          puts "Parking lot is empty"
        else
          match = ""
          @slots.each do |slot|
            if slot && slot.colour == argv_arr[1]
              if match.size == 0
                match = slot.reg_num
              else
                match = match + ", #{slot.reg_num}"
              end
            end
          end # end of @slots.each
          puts match
        end
      when "slot_numbers_for_cars_with_colour"
        if @num_cars == 0
          puts "Parking lot is empty"
        else
          match = ""
          @slots.each_with_index do |slot, i|
            if slot && slot.colour == argv_arr[1]
              if match.size == 0
                match = (i+1).to_s
              else
                match = match + ", #{(i+1).to_s}"
              end
            end
          end # end of @slots.each
          puts match
        end

      when "slot_number_for_registration_number"
        if @num_cars == 0
          puts "Parking lot is empty"
        else
          match = ""
          @slots.each_with_index do |slot, i|
            if slot && slot.reg_num == argv_arr[1]
              if match.size == 0
                match = (i+1).to_s
              else
                match = match + ", #{(i+1).to_s}"
              end
            end
          end # end of @slots.each

          if match.size == 0
            puts "Not found"
          else
            puts match
          end
        end

      else
        puts "Wrong command"

    end # end of case action

  end # end of def process_input

end
