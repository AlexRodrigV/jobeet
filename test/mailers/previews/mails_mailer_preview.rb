# Preview all emails at http://localhost:3000/rails/mailers/mails_mailer
class MailsMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/mails_mailer/updateOffer
  def updateOffer
    MailsMailer.updateOffer
  end

end
