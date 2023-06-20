class AdminMailer < ApplicationMailer
    default :from => ENV['MAILJET_DEFAULT_FROM']

    def confirmation_email(order)
        #on récupère l'instance order pour ensuite pouvoir la passer à la view en @user
        @order = order
    
        #on définit une variable @url qu'on utilisera dans la view d’e-mail
        @url  = 'http://bardic-reveries.com/login' 
    
        # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
        mail(to: @user.email, subject: 'Nouvelle histoire sur le site') 
 

      end
end
