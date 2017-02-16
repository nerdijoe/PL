require 'csv'
require 'io/console'

class Car
  def initialize(**input)
    @reg_num = input.fetch(:reg_num)
    @colour = input.fetch(:colour)
  end


end


class ParkingLot
  def initialize(**input)
    @num_slots = input.fetch(:num_slots)
    @slots = nil
    @file = input.fetch(:file)
  end

end
