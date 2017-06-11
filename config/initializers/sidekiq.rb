Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'],
                   db: ENV['REDIS_DB'],
                   namespace: ENV['REDIS_NAMESPACE']
  }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'],
                   db: ENV['REDIS_DB'],
                   namespace: ENV['REDIS_NAMESPACE']
  }
end

schedule_file = 'config/schedule.yml'

if File.exists?(schedule_file) && Sidekiq.server?
  Sidekiq.configure_server do |config|
    config.on(:startup) do
      Sidekiq.schedule = YAML.load_file(schedule_file)
      Sidekiq::Scheduler.reload_schedule!
    end
  end
end
