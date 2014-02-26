module KevinBaconator
  class << self
    def run!
      (1..100).each do |num|
        puts bacon(num)
      end
    end

    def bacon(num)
      return 'Kevin Bacon' if should_be_kevin_bacon?(num)
      return 'Kevin'       if should_be_kevin?(num)
      return 'Bacon'       if should_be_bacon?(num)
      num
    end

    private
    def should_be_kevin_bacon?(num)
      should_be_kevin?(num) && should_be_bacon?(num)
    end

    def should_be_kevin?(num)
      num % 3 == 0
    end

    def should_be_bacon?(num)
      num % 5 == 0
    end
  end
end

def assert_baconator(input, output)
  results = []
  input.each do |num|
    results << KevinBaconator.bacon(num)
  end
  results.uniq.should == [output].flatten
end

def assert_baconator_received_puts_with(arg)
  KevinBaconator.should_receive(:puts).with(arg)
end

describe KevinBaconator do
  it "returns numbers that aren't multiples of 3 or 5" do
    nums = [1, 2, 4, 7, 11, 97]
    assert_baconator(nums, nums)
  end

  it "returns 'Kevin' for multiples of 3" do
    assert_baconator([3, 6, 9, 12, 333], 'Kevin')
  end

  it "returns 'Bacon' for multiples of 5" do
    assert_baconator([5, 10, 20, 25, 550], 'Bacon')
  end

  it "returns 'Kevin Bacon' for multiples of 3 and 5" do
    assert_baconator([15, 30, 45, 90, 555], 'Kevin Bacon')
  end

  describe "Integration test with .run!" do
    it "prints the numbers 1-100 with the baconator rules applied" do
      (1..100).each do |num|
        if num % 3 == 0 && num % 5 == 0
          assert_baconator_received_puts_with('Kevin Bacon')
        elsif num % 3 == 0
          assert_baconator_received_puts_with('Kevin')
        elsif num % 5 == 0
          assert_baconator_received_puts_with('Bacon')
        else
          assert_baconator_received_puts_with(num)
        end
      end

      KevinBaconator.run!
    end
  end
end
