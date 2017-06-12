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
    if @cookie
      create_cookie(JSON.parse(@cookie)['id'])
    else
      @cookie = request.cookies[COOKIE_NAME] || create_cookie
    end
  end

  def create_cookie(*uuid)
    _url = Domainatrix.parse(request.referrer)
    _uuid = uuid.empty? ? SecureRandom.uuid : uuid[0]
    data = {
      id: _uuid,
      url: _url.url,
      domain: [_url.domain, _url.public_suffix].join('.'),
      path: _url.path,
      visited_at: Time.zone.now.to_s
    }
    # cache_contact(data)
    create_client_path_from(data)
    JSON.dump(data)
  end

  def cache_contact(data)
    TrackerServices::UserDataCache.call(data)
  end

  def create_client_path_from(tracker_data)
    clients = ContactPath.where(tracker_id: tracker_data[:id])
                         .where(path: tracker_data[:path])

    return unless clients.empty?

    cp = ContactPath.new(tracker_data.except(:id))
    cp.tracker_id = tracker_data[:id]

    if cp.save
      c = Contact.joins(:contact_paths)
                 .where(contact_paths: { tracker_id: tracker_data[:id] }).first

      c.contact_paths << cp if c
    end
  end
end
