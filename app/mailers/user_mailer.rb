class UserMailer < ApplicationMailer
  default from: "no-reply@jungle.com"

    def checkout_email(order, totalcents, orderid, currentuser)
      @order = order
      @total_cents = totalcents / 100
      mail(to: currentuser.email, subject: "Receipt for order number #{orderid} ")
  end

end
