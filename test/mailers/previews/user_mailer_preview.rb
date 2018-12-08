class UserMailerPreview < ActionMailer::Preview

  def checkout_email
    UserMailer.checkout_email(@order, current_user)
  end

end