require 'fluent/test'
require 'fluent/plugin/out_better_timestamp'

class BetterTimestampOutputTest < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    type better_timestamp
    tag foo.filtered
    msec_key msec
    timestamp_key
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::OutputTestDriver.new(Fluent::BetterTimestampOutput, tag='test_tag').configure(conf)
  end

  def test_configure
    d = create_driver
    map = d.instance.instance_variable_get(:@map)

    #assert_equal 'msec', map['msec_key']
  end

  def test_remove_one_key
    d = create_driver %[
      type record_modifier
      tag foo.filtered
      msec_key msec
    ]

    mapped = {}

    d.run do
      d.emit("msec" => '1', "k1" => 'v')
    end

    assert d.records[0]['@timestamp']
  end
end
