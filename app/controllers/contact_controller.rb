class ContactController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :verify_email]

  def index
    @contacts = Contact.order(name: :asc).page(params['page'])
  end

  def create
    Contact.create(contact_params) do |c|
      c.contact_paths << ContactPath.where(tracker_id: params[:tracker_id])
    end
    render json: { status: 200 }
  end

  def show
    @contact = Contact.find(params[:id])
  end

  def verify_email
    emails = Contact.where(email: params[:email]).pluck(:email)
    result = emails.size.zero? ? true : false
    render json: { valid: result }
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :subject, :message)
  end
end
