class MailsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mails_mailer.updateOffer.subject
  #
  def updateOffer(offer, user)
    @Information = "The offer " + offer.title + " has been modified"
    mail to: user.email, subject: @Information
  end
end
