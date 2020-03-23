class WebPushSubscriber < ApplicationRecord
  validates_presence_of :endpoint, :auth, :p256dh, :latitude, :longitude

  def notify(title: "CrowdCovid", body:, action_title: nil, action_href: "https://www.crowdcovid.com")
    payload = { title: title,
                body: body }

    if action_title
      payload[:action] = { title: action_title,
                           href: action_href }
    end

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
  end
end
