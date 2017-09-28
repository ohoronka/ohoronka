class TestMailer < ApplicationMailer
  def test
    mail(to: 'biguban@gmail.com', subject: 'Test')
  end
end
