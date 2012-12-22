require "crappy_counter/version"

module CrappyCounter

  NoRedisFound = Class.new(StandardError)

  def self.incr(opts)
    raise NoRedisFound unless $redis

    combined_key = ""
    opts[:keys].each do |key|
      combined_key << (combined_key.empty? ? key : ":#{key}")
      $redis.incr combined_key

      date_key = ""
      if opts[:date]
        date = opts[:date]
        date_key << "#{combined_key}:"
        [:year, :month, :day].each do |date_param|
          next unless date.respond_to?(date_param)
          date_key << date.send(date_param).to_s
          $redis.incr date_key
        end
      end
    end
  end

  def self.lpush(opts)
    raise NoRedisFound unless $redis

    combined_key = ""
    opts[:keys].each do |key|
      combined_key << (combined_key.empty? ? key : ":#{key}")
      $redis.lpush combined_key, opts[:values]
    end

  end

end
