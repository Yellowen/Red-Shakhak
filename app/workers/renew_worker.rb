class RenewWorker
  include Sidekiq::Worker

  def perform(obj, count)
    advertise = Advertise.find(obj["id"].to_i)
    advertise.renew(obj["show_for_days"].to_i, obj["cost"].to_i)
  end
end
