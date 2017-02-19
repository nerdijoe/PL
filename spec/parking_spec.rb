require 'spec_helper'
require 'byebug'
describe Parking do
  before :each do
    @parking = Parking.new
  end

  describe "#new" do
      it "takes no argument" do
          expect(@parking).to be_instance_of(Parking)
      end

      it "has 0 number of cars" do
        expect(Parking.num_cars).to eq(0)
      end
  end


end
