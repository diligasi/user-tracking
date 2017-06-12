module RedisObj
  class UserCache < RedisObject
    attr_reader :queue_name

    list :users, marshal: true

    def initialize(queue_name)
      @queue_name = queue_name
    end

    def id
      @queue_name
    end

    def cache(data = {})
      return if data.blank?
      self.users << data
    end
  end
end
