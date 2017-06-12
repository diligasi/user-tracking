class ContactController < ApplicationController

  def index
    @contacts = Contact.order(name: :asc).page(params['page'])
  end
end
