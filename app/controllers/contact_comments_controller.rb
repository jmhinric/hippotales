# == Schema Information
#
# Table name: contact_comments
#
#  id         :uuid             not null, primary key
#  name       :string
#  email      :string
#  message    :text
#  replied    :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
