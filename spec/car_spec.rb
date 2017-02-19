require 'spec_helper'

describe Car do

  before :each do
    @car = Car.new(reg_num: "AAA", colour: "Green")
  end

  describe "#new" do
      it "takes two arg to create an object of car" do
          expect(@car).to be_instance_of(Car)
      end

      it "has the correct properties" do
        expect(@car.reg_num).to eq("AAA")
        expect(@car.colour).to eq("Green")
      end
  end

end
