  require 'test/unit'

  class MainTest < Test::Unit::TestCase

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

    def test_ok

      assert_equal(1, 1)
    end

  end