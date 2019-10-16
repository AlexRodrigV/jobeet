require 'test_helper'

class MailsMailerTest < ActionMailer::TestCase
  test "updateOffer" do
    mail = MailsMailer.updateOffer
    assert_equal "Updateoffer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
