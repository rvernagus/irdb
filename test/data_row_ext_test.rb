require File.join(File.dirname(__FILE__), 'test_helper')

class FirstTest < Test::Unit::TestCase
  context 'a first test' do
    should 'pass' do
      assert_equal 1, 1
    end
  end
end
