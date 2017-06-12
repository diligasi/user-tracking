class TrackerController < ActionController::Base
  layout false

  COOKIE_NAME = '_server.cookie'.freeze

  # Receives a +POST+ request from the partner's page
  # and create a +cookie+ with an identifier for the
  # current client.
  #
  # Returns the +cookie+ object
  #
  # ==== Output object format
  #   {
  #     id          : 'ajsd9fauys98dfu9ja9s8udf98asuf98',
  #     url         : 'http://www.partner.com.br/contato',
  #     domain      : 'partner.com.br',
  #     path        : '/contato',
  #     visited_at  : 'Sun Jun 11 2017 18:32:14 GMT-0300 (BRT)'
  #   }
  def cookie_handler
    response.set_cookie(COOKIE_NAME, cookie_data)
    render json: cookie_data
  end

  private

  def cookie_data
    @cookie ||= request.cookies[COOKIE_NAME] || create_cookie
  end

  def create_cookie
    _url = Domainatrix.parse(request.referrer)
    data = {
      id: SecureRandom.uuid,
      url: _url.url,
      domain: [_url.domain, _url.public_suffix].join('.'),
      path: _url.path,
      visited_at: Time.zone.now.to_s
    }
    cache_contact(data)
    JSON.dump(data)
  end

  def cache_contact(data)
    TrackerServices::UserDataCache.call(data)
  end
end
