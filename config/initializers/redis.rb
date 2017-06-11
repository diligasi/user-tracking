cache_config = {
  namespace: ENV['REDIS_NAMESPACE'],
  url: ENV['REDIS_URL'],
  db: ENV['REDIS_DB']
}

Rails.cache = ActiveSupport::Cache::RedisStore.new(cache_config)
Redis::Objects.redis = Redis.new(cache_config)
