class WebPushSubscriber < ApplicationRecord
  attr_accessor :payload

  validates_presence_of :endpoint, :auth, :p256dh, :latitude, :longitude

  self.implicit_order_column = "created_at"

  scope :active, -> { where(unsubscribed_at: nil) }

  def self.notify_all_heartbeat
    active.each do |subscriber|
      subscriber.notify_heartbeat
    end
  end

  def notify_heartbeat
    notify(title: "How are you feeling today?",
           body: "Update your status on CrowdCovid",
           action_title: "Fill out form")
  end

  def notify(title: "CrowdCovid", body:, action_title: nil, action_href: "https://www.crowdcovid.com")
    self.payload = { title: title,
                     body: body }

    if action_title
      self.payload[:action] = { title: action_title,
                                href: action_href }
    end

    deliver_later
  end

  def unsubscribe
    update!(unsubscribed_at: DateTime.now)
  end

  private

  def job_data
    { id: id,
      payload: payload,
      endpoint: endpoint,
      p256dh: p256dh,
      auth: auth }
  end

  def deliver_now
    DeliverWebPushJob.perform_now job_data
  end

  def deliver_later
    DeliverWebPushJob.perform_later job_data
  end
end
