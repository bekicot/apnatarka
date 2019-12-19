class UserMailer < ApplicationMailer
include SendGrid
  def account_creation_email(user)
    @user = user
    mail(to: @user.email, subject: 'Your account on 20/40 Email')
  end

  def contact_request_email(emails, contact_request)
    @contact_request = contact_request
    mail(to: emails, subject: 'Contact Request on 20/40 ')
  end

  def feedback_email(emails, feedback)
    @feedback = feedback
    mail(to: emails, subject: 'Feedback on 20/40 ')
  end

  def franchise_email(emails, franchise)
    @franchise = franchise
    mail(to: emails, subject: 'Franchises on 20/40 ')
  end
end
