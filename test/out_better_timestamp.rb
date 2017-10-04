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
    timestamp_key @timestamp
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::OutputTestDriver.new(Fluent::BetterTimestampOutput, tag='test_tag').configure(conf)
  end

  def test_configure
    d = create_driver

    assert_equal 'msec', d.instance.msec_key
  end

  def test_remove_one_key
    d = create_driver %[
      type record_modifier
      tag foo.filtered
      msec_key msec
    ]

    mapped = {}

    msec = 1
    time = Time.now
    time_str = Time.at(time.to_r, msec * 1000).strftime("%Y-%m-%dT%H:%M:%S.%L%z")
    d.run do
      d.emit({"msec" => msec.to_s, "k1" => 'v'}, time.to_r)
    end

    assert_equal time_str, d.records[0]['@timestamp']
    assert d.records[0]['@timestamp']
  end
end
