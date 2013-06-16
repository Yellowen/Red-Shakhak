class RenewWorker
  include Sidekiq::Worker

  def perform(obj, count)

    # Sleep for 1 second to ensure that the advertise is expired
    sleep 1
    advertise = Advertise.find(obj["id"].to_i)
    advertise.renew(obj["show_for_days"].to_i, obj["cost"].to_i)

  end
end
