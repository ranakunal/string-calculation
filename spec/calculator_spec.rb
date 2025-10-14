require 'spec_helper'
require_relative '../calculator'

describe 'Calculator' do
  context "when given simple input strings" do
    let(:input_string) { '"", "1", "1,5"' }

    it "returns formatted input strings" do
      calculator = Calculator.new(input_string)
      expect(calculator.input_strings).to eq(["", "1", "1,5"])
    end

    it "returns addition results" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq('0, 1, 6')
    end
  end

  context "when given multiple sets of comma-separated numbers" do
    let(:input_string) { '"1,10,20", "1,5,20,44,50"' }

    it "returns formatted input and correct addition results" do
      calculator = Calculator.new(input_string)
      expect(calculator.input_strings).to eq(["1,10,20", "1,5,20,44,50"])
      expect(calculator.add).to eq('31, 120')
    end
  end

  context "when input strings contain newline characters" do
    let(:input_string) { '"1\n5", "1,20"' }

    it "returns formatted input strings" do
      calculator = Calculator.new(input_string)
      expect(calculator.input_strings).to eq(["1,5", "1,20"])
    end

    it "returns correct addition results" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq('6, 21')
    end
  end

  context "when input strings contain multiple newline characters" do
    let(:input_string) { '"1\n5\n15\n20", "1\n2\n3\n4\n5"' }

    it "returns formatted input and addition results" do
      calculator = Calculator.new(input_string)
      expect(calculator.input_strings).to eq(["1,5,15,20", "1,2,3,4,5"])
      expect(calculator.add).to eq('41, 15')
    end
  end

  context "when input strings include a custom delimiter" do
    let(:input_string) { '"//:\n1:2:5", "1,2,5"' }

    it "returns correct addition results" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq('8, 8')
    end
  end

  context "when custom delimiter is followed by an invalid character" do
    let(:input_string) { '"//:\n1:2,5", "1,2,5"' }

    it "returns partial addition results" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq('3, 8')
    end
  end

  context "when newline appears at the end of a string" do
    let(:input_string) { '"//:\n1:2:5\n", "1,2,5"' }

    it "returns an exception for invalid format" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq("Invalid character at the end of string")
    end
  end

  context "when negative numbers are present in input" do
    let(:input_string) { '"1,-2,3,4", "1,2,5"' }

    it "raises an exception for negative numbers" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq("Negative numbers not allowed: -2")
    end
  end

  context "when multiple negative numbers are present" do
    let(:input_string) { '"1,-2,3,-4,-6", "1,2,5"' }

    it "raises an exception listing all negative numbers" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq("Negative numbers not allowed: -2, -4, -6")
    end
  end

  context "when input includes non-numeric characters or extra spaces" do
    let(:input_string) { '"1,a,3,b", "1, 2, 5"' }

    it "ignores invalid characters and returns correct sums" do
      calculator = Calculator.new(input_string)
      expect(calculator.add).to eq('4, 8')
    end
  end
end
