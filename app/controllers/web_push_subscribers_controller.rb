class WebPushSubscribersController < ApplicationController
  def create
    subscriber = WebPushSubscriber.new(subscriber_params)

    if subscriber.valid?
      # Insert new or update if endpoint exists
      db_subscriber = WebPushSubscriber.find_or_initialize_by(endpoint: subscriber_params[:endpoint])
      db_subscriber.assign_attributes(subscriber_params.except(:expires_at))

      if expires_at = subscriber_params[:expires_at]
        db_subscriber.expires_at = Time.at(expires_at)
      end

      db_subscriber.save!

      # db_subscriber.notify(body: "It works", action_title: "Have a look")
      # db_subscriber.notify(body: "Just saying")

      head :no_content

    else

      head :no_content
    end
  end

  private

  def subscriber_params
    params.permit(:endpoint, :auth, :p256dh, :expires_at, :latitude, :longitude)
  end
end
