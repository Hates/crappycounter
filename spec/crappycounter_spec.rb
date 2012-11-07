require File.dirname(__FILE__) + '/spec_helper'

describe CrappyCounter do

  it "raises an error if $redis is not defined" do
    expect {
      CrappyCounter.incr "key"
    }.to raise_error(CrappyCounter::NoRedisFound)
  end

  context "no date" do

    before(:each) do
      $redis = double "Redis"
    end

    it "increments a single key" do
      $redis.should_receive(:incr).with("first_key")

      CrappyCounter.incr keys: ["first_key"]
    end

    it "increments multiple keys" do
      $redis.should_receive(:incr).with("first_key")
      $redis.should_receive(:incr).with("first_key:second_key")

      CrappyCounter.incr keys: ["first_key", "second_key"]
    end

  end

  context "with a date" do

    let(:today) {
      today = double "Date"
      today.stub(:year => "2000")
      today.stub(:month => "12")
      today.stub(:day => "31")
      today
    }

    before(:each) do
      $redis = double "Redis"
    end

    it "ignores an invalid date" do
      today = "non-date"

      $redis.should_receive(:incr).with("first_key")

      CrappyCounter.incr keys: ["first_key"], date: today
    end

    it "ignores a nil date" do
      $redis.should_receive(:incr).with("first_key")

      CrappyCounter.incr keys: ["first_key"], date: nil
    end

    it "increments a single key" do
      $redis.should_receive(:incr).with("first_key")
      $redis.should_receive(:incr).with("first_key:2000")
      $redis.should_receive(:incr).with("first_key:200012")
      $redis.should_receive(:incr).with("first_key:20001231")

      CrappyCounter.incr keys: ["first_key"], date: today
    end

    it "increments multiple keys" do
      $redis.should_receive(:incr).with("first_key")
      $redis.should_receive(:incr).with("first_key:2000")
      $redis.should_receive(:incr).with("first_key:200012")
      $redis.should_receive(:incr).with("first_key:20001231")
      $redis.should_receive(:incr).with("first_key:second_key")
      $redis.should_receive(:incr).with("first_key:second_key:2000")
      $redis.should_receive(:incr).with("first_key:second_key:200012")
      $redis.should_receive(:incr).with("first_key:second_key:20001231")

      CrappyCounter.incr keys: ["first_key", "second_key"], date: today
    end

  end

end
