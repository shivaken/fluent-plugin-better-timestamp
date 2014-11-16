require 'fluent/mixin/config_placeholders'

module Fluent
  class BetterTimestampOutput < Output
    Fluent::Plugin.register_output('better_timestamp', self)

    config_param :tag, :string
    config_param :msec_key, :string, :default => 'msec'
    config_param :timestamp_key, :string, :default => '@timestamp'

    include SetTagKeyMixin
    include Fluent::Mixin::ConfigPlaceholders

    BUILTIN_CONFIGURATIONS = %W(type tag timestamp_key msec_key)

    def configure(conf)
      super

      @map = {}
      conf.each_pair { |k, v|
        unless BUILTIN_CONFIGURATIONS.include?(k)
          conf.has_key?(k)
          @map[k] = v
        end
      }

    end

    def emit(tag, es, chain)
      es.each { |time, record|
        filter_record(tag, time, record)
        Engine.emit(@tag, time, modify_record(time, record))
      }

      chain.next
    end

    private

    def modify_record(time, record)
      if record[@msec_key] then
        record[@timestamp_key] = Time.at(time, record[@msec_key].to_i * 1000).strftime("%Y-%m-%dT%H:%M:%S.%L%z")
        record.delete(@msec_key)
      end
      record
    end
  end
end
