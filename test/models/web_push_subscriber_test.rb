require 'test_helper'

class WebPushSubscriberTest < ActiveSupport::TestCase
  test "active scope" do
    assert_changes("WebPushSubscriber.active.count") do
      WebPushSubscriber.first.unsubscribe
    end
  end
end
