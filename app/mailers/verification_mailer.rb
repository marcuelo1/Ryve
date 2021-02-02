class VerificationMailer < ApplicationMailer
    default from: 'ryve.public@gmail.com'
    
    def send_code(user)
        @user = user
        mail(to: @user.email, subject: "Verification Code For Ryve")
    end
end
