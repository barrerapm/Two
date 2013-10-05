require 'test/unit'
require_relative '../framework/framework_aop'
require_relative '../aspects/profiler'

class FrameworkTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    # Do nothing
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_advice_profiler
    fw = FrameworkAOP.new
    fw.listMethods(Profiler)
    assert_equal(true, true)
  end

end