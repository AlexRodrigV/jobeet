class MailsMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mails_mailer.updateOffer.subject
  #
  def updateOffer(offer, user)
    @Information = "The offer " + offer.title + " has been modified."
    mail to: user.email, subject: "Information on " + offer.title
  end

  def deleteOffer(offer, user)
    @Information = "A recruiter has delete the offer " + offer.title + "."
    mail to: user.email, subject: "Offer " + offer.title + " is deleted"
  end

  def acceptUser(offer, user)
    @Information = "You had a match with " + offer.title + "."
    mail to: user.email, subject: "Congratulation you\'ve been accepted on " + offer.title
  end

  def rejectUser(offer, user)
    @Information = "A recruiter has delete your match on " + offer.title + "."
    mail to: user.email, subject: "Match deleted on " + offer.title
  end
end
