class DeliverWebPushJob < ApplicationJob
  queue_as :default

  def perform(id:, payload:, endpoint:, p256dh:, auth:)
    begin
      Webpush.payload_send(
        message: JSON.generate(payload),
        endpoint: endpoint,
        p256dh: p256dh,
        auth: auth,
        vapid: {
          subject: "mailto:info@crowdcovid.com",
          public_key: Rails.application.credentials.vapid_public_key,
          private_key: Rails.application.credentials.vapid_private_key
        },
        ssl_timeout: 5, # value for Net::HTTP#ssl_timeout=, optional
        open_timeout: 5, # value for Net::HTTP#open_timeout=, optional
        read_timeout: 5 # value for Net::HTTP#read_timeout=, optional
      )

    rescue Webpush::InvalidSubscription => _exception
      WebPushSubscriber.find(id).unsubscribe
    end
  end
end
