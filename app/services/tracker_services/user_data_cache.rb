class TrackerServices::UserDataCache
  attr_accessor :user_data

  def self.call(params)
    this = new(params)
    this.call
  end

  def initialize(data)
    self.user_data = data
  end

  def call
    return unless valid_data?
    enqueue!
  end

  private

  def valid_data?
    UserDataSchema.call(user_data).success?
  end

  def enqueue!
    RedisObj::UserCache.new('captured_user').cache(user_data)
  end
end
