class NoticeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notice_mailer.sendmail_contacts.subject
  #

  def sendmail_blog(blog)
    @blog = blog
    mail to: "kazutooo.110@gmail.com",
    subject: '【FFacebook】ブログが投稿されました'
  end

  def sendmail_contacts(contact)
    @contact = contact
    mail to: @contact.email,
    subject: '【FFacebook】お問い合わせが完了しました'
  end
end
