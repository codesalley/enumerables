require 'enumerables'

puts '\nNOTE: All test must be passed'

describe 'Enumerable' do
  let(:my_enumerables) { Enumerable.new }
  describe '#my_each' do
    it 'my_each must be an Enumerator ' do
      expect([1, 2, 3].my_each.instance_of?(Enumerator)).to eq(true)
    end
    it 'when a block is given when self is an array returns the array itself
      after calling the given block once for each element in self' do
      expect([1, 2, 3, 4, 5].each(&proc { |n| n % 2 }) == [1, 2, 3, 4, 5].my_each(&proc { |n| n % 2 })).not_to eq(false)
    end
  end
  describe '#my_each_index' do
    it 'my_each_with_index must be an Enumerator ' do
      expect([1, 2, 3].my_each_with_index.instance_of?(Enumerator)).to eq(true)
    end
    it 'my_each_with_index when a block is given when self is a range' do
      concat1 = ''
      (1..4).each_with_index(&proc { |n, i| concat1 += "n: #{n}, i: #{i}+++" })
      concat2 = ''
      (1..4).my_each_with_index(&proc { |n, i| concat2 += "n: #{n}, i: #{i}+++" })

      expect(concat1 == concat2).to eq(true)
    end
  end
  describe '#my_select' do
    it 'returns an enumerator if no block is given' do
      expect([1, 2, 3, 4].my_select.instance_of?(Enumerator)).not_to eq(false)
    end
    it 'ruturn array of all selected elements' do
      expect([1, 2, 3, 4].my_select { |ele| ele > 2 }).to eq([3, 4])
    end
  end
  describe '#my_count' do
    it 'Returns the length of the given object' do
      expect([1, 2, 3, 2, 4, 6, 7, 4, 3, '2'].my_count).to eq(10)
    end
  end
  describe '#my_all?' do
    it 'when a Regex is passed as an argument returns true if all
          of the collection matches the Regex ' do
      expect(%w[car cat].all?(/a/) == %w[car cat].my_all?(/a/)).not_to eq(false)
    end
    it 'when a class is passed as an argument returns true if all of the
         collection is a member of such class::Numeric' do
      expect([1, -2, 3.4].all?(Numeric) != [1, -2, 3.4].my_all?(Numeric)).to eq(false)
    end
  end
  describe '#my_any?' do
    it 'when no block or argument is given returns false if at least one of the collection is not true' do
      expect([false, 0].any? == [false, 0].my_any?).to eq(true)
    end
    it 'when an array is given with a block, it should perform the function on every element of the array' do
      expect([2, 3, 4, 4, 4, 3, 2, 2, 1].my_any?(&:odd?)).to eq(true)
    end
  end
  describe '#my_none? ' do
    it 'returns false if the block ever returns true for all elements::range' do
      expect((1..3).none?(&proc { |num| num.even? }) == (1..3).my_none?(&proc { |num| num.even? })).to eq(true)
    end
    it ' when no block or argument is given returns false only if one of the collection members is true' do
      expect([false, nil, []].none? != [false, nil, []].my_none?).to eq(false)
    end
  end
  describe '#my_map' do
    it 'should returns an Enumerator if no block is given' do
      expect([1, 2, 3].map.instance_of?([1, 2, 3].my_map.class)).to eq(true)
    end
    it 'when an array is given with a block, it should perform the function on every element of the array ' do
      expect([1, 2, 3].my_map { |ele| ele * 3 }).to eq([3, 6, 9])
    end
  end
  describe '#my_inject' do
    it 'should searches for the longest word in an array of strings ' do
      expect(%w[to four tri].my_inject(&proc { |a, b| [a, b].max_by(&:length) }) ==
               %w[to four tri].inject(&proc { |a, b| [a, b].max_by(&:length) })).to eq(true)
    end
    it 'when a block is given without an initail value combines all elements of enum by
        §applying a binary operation, specified by a block::range' do
      expect((1..3).inject(&proc { |total, num| total * num }) == (1..3).my_inject(&proc { |total, num|
                                                                                      total * num
                                                                                    })).not_to eq(false)
    end
  end
end
