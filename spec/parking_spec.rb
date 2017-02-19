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

  describe "Creates parking slots input" do

    it "creates 3 parking slots" do
      input = "create_parking_lot 3".split(" ")
      $stdout = StringIO.new
      @parking.process_input(input)
      $stdout.rewind   # IOs act like a tape so we rewind to inspect the previous stdout

      expect($stdout.gets.strip).to eq('Created a parking lot with 3 slots')

    end

  end

  describe "Parking a car and Car Leave actions" do
    before do
      @parking.process_input("create_parking_lot 3".split(" "))
    end

    it "parks a car, increase the number of cars by one" do
      input = "park KA-01-HH-1234 White".split(" ")
      @parking.process_input(input)
      expect(Parking.num_cars).to eq(1)
    end

    it "leaves a car, decrease the number of cars by one" do
      input = "leave 1".split(" ")
      @parking.process_input(input)
      expect(Parking.num_cars).to eq(0)
    end

    it "fills the parking slots, then try to park another car" do
      input = "park KA-01-HH-1234 White".split(" ")
      @parking.process_input(input)
      input = "park KA-01-HH-9999 White".split(" ")
      @parking.process_input(input)
      input = "park KA-01-BB-0001 Black".split(" ")
      @parking.process_input(input)
      expect(Parking.num_cars).to eq(3)

    end

  end


  describe "Fills the parking slots" do
    before do
      @parking2 = Parking.new
      @parking2.process_input("create_parking_lot 3".split(" "))
      @parking2.process_input("park KA-01-HH-1234 White".split(" "))
      @parking2.process_input("park KA-01-HH-9999 White".split(" "))
      @parking2.process_input("park KA-01-BB-0001 Black".split(" "))


    end

    it "Parks another car" do
      expect do
        @parking2.process_input("park KA-01-HH-7777 Red".split(" "))
      end.to output("Sorry, parking lot is full\n").to_stdout
    end

    it "Parking lot is full, then another car is coming to park" do
      expect do
        @parking2.process_input("park KA-01-HH-7777 Red".split(" "))
      end.to output("Sorry, parking lot is full\n").to_stdout
    end

    it "One car leaves from slot 2" do
      expect do
        @parking2.process_input("leave 2".split(" "))
      end.to output("Slot number 2 is free\n").to_stdout
    end

    it "One car leaves from slot 2, then another car is coming to park at slot 2" do
      @parking2.process_input("leave 2".split(" "))
      expect do
        @parking2.process_input("park KA-01-HH-7777 Red".split(" "))
      end.to output("Allocated slot number: 2\n").to_stdout

    end


  end


end
