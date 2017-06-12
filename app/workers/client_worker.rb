class ClientWorker
  include Sidekiq::Worker
  sidekiq_options(retry: false, queue: :default, dead: true)

  def perform(*args)
    3_000.times do
      client_tracker_data = RedisObj::UserCache.new('captured_user').users.shift
      break if client_tracker_data.nil?
      clients = ContactPath.where(tracker_id: client_tracker_data[:id])
                           .where(domain: client_tracker_data[:domain])

      create_client_path_from(client_tracker_data) if clients.empty?
    end
  end

  private

  def create_client_path_from(tracker_data)
    cp = ContactPath.new(tracker_data.except(:id))
    cp.tracker_id = tracker_data[:id]
    if cp.save
      c = Contact.joins(:contact_paths)
                 .where(contact_paths: { tracker_id: tracker_data[:id] }).first

      c.contact_paths << cp
    end
  end
end
