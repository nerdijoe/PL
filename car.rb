class Car
  attr_reader :reg_num, :colour
  def initialize(**input)
    @reg_num = input.fetch(:reg_num)
    @colour = input.fetch(:colour)
  end
end
