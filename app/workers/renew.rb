class RenewWorker
  include SideKiq::Worker

  def perform(obj, count)
    advertise = Advertise.find(obj[:id])
    advertise.renew(obj[:days], obj[:cost])
  end
end
