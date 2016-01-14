class ContactCommentsController < ApplicationController
  def new
    @contact_comment = ContactComment.new
  end

  def create
    @contact_comment = ContactComment.create!(contact_params)

    flash[:notice] = "We received your comment and will get back to you shortly- thank you!"
    redirect_to contact_path
  rescue Exception => e
    flash[:error] = "Sorry, something went wrong. Please try emailing us with the link at the side."
    redirect_to contact_path
  end

  def contact_params
    params.require(:contact_comment).permit(:name, :email, :message)
  end
end
