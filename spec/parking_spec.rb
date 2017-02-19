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
        expect(@parking.num_cars).to eq(0)
      end
  end

  describe "Creates parking slots input" do

    it "creates 3 parking slots" do
      # input = "create_parking_lot 3".split(" ")
      # $stdout = StringIO.new
      # @parking.process_input(input)
      # $stdout.rewind   # IOs act like a tape so we rewind to inspect the previous stdout
      #
      # expect($stdout.gets.strip).to eq('Created a parking lot with 3 slots')

      input = "create_parking_lot 3".split(" ")
      expect do
        @parking.process_input(input)
      end.to output("Created a parking lot with 3 slots\n").to_stdout

    end

  end

  describe "Parking a car and Car Leave actions" do
    before do
      @parking.process_input("create_parking_lot 3".split(" "))
    end

    it "parks a car, increase the number of cars by one" do
      input = "park KA-01-HH-1234 White".split(" ")
      @parking.process_input(input)
      expect(@parking.num_cars).to eq(1)
    end

    it "leaves a car, decrease the number of cars by one" do
      input = "leave 1".split(" ")
      @parking.process_input(input)
      expect(@parking.num_cars).to eq(0)
    end

    it "fills the parking slots, then try to park another car" do
      input = "park KA-01-HH-1234 White".split(" ")
      @parking.process_input(input)
      input = "park KA-01-HH-9999 White".split(" ")
      @parking.process_input(input)
      input = "park KA-01-BB-0001 Black".split(" ")
      @parking.process_input(input)
      expect(@parking.num_cars).to eq(3)

    end

  end


  describe "Fills the parking slots" do

    # let(:parking) {Parking.new}

    before do
      @parking2 = Parking.new
      input = "create_parking_lot 3".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-HH-1234 White".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-HH-9999 White".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-BB-0001 Black".split(" ")
      @parking2.process_input(input)
    end

    it "Checks for registration number with colour White" do
      input = "registration_numbers_for_cars_with_colour White".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("KA-01-HH-1234, KA-01-HH-9999\n").to_stdout
    end

    it "Checks for slot number for cars with colour White" do
      input = "slot_numbers_for_cars_with_colour White".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("1, 2\n").to_stdout
    end

    it "Parking lot is full, then another car is coming to park" do
      input = "park KA-01-HH-7777 Red".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("Sorry, parking lot is full\n").to_stdout
    end

    it "One car leaves from slot 2" do
      input = "leave 2".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("Slot number 2 is free\n").to_stdout
    end

    it "One car leaves from slot 2, then another car is coming to park at slot 2" do
      input = "leave 2".split(" ")
      @parking2.process_input(input)

      input = "park KA-01-HH-7777 Red".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("Allocated slot number: 2\n").to_stdout
    end

    it "Checks for registration number with colour Green, it will print empty string" do
      input = "registration_numbers_for_cars_with_colour Green".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("\n").to_stdout
    end

    it "Checks for slot number for cars with colour Green, it will not print empty string" do
      input = "slot_numbers_for_cars_with_colour Green".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("\n").to_stdout
    end

    it "Checks for slot number for cars with registration number RANDOM, it will print Not found message" do
      input = "slot_number_for_registration_number RANDOM".split(" ")
      expect do
        @parking2.process_input(input)
      end.to output("Not found\n").to_stdout
    end

  end


  describe "Fills the parking slots, one car at slot 2 leaves, then a Red car with reg number KA-01-HH-7777 parks at slot 2" do
    before do
      @parking2 = Parking.new
      input = "create_parking_lot 3".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-HH-1234 White".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-HH-9999 White".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-BB-0001 Black".split(" ")
      @parking2.process_input(input)
      input = "leave 2".split(" ")
      @parking2.process_input(input)
      input = "park KA-01-HH-7777 Red".split(" ")
      @parking2.process_input(input)
    end

    it "Checks for registration number with colour Red" do
      expect do
        @parking2.process_input("registration_numbers_for_cars_with_colour Red".split(" "))
      end.to output("KA-01-HH-7777\n").to_stdout
    end

    it "Checks for slot number for cars with colour Red" do
      expect do
        @parking2.process_input("slot_numbers_for_cars_with_colour Red".split(" "))
      end.to output("2\n").to_stdout
    end

    it "Checks for slot number for cars with registration number KA-01-HH-7777" do
      expect do
        @parking2.process_input("slot_number_for_registration_number KA-01-HH-7777".split(" "))
      end.to output("2\n").to_stdout
    end


  end



end
