class UserMailer < ApplicationMailer
  default :from => 'bardic-reveries@yopmail.com'

    def welcome_email(user)
        #on récupère l'instance user pour ensuite pouvoir la passer à la view en @user
        @user = user 
    
        #on définit une variable @url qu'on utilisera dans la view d’e-mail
        @url  = 'www.bardic-reveries.com' 
    
        # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
        mail(to: @user.email, subject: 'Bienvenue dans les rêves de Bardic Reveries !') 
 
      end


      def confirmation_email(user,order)
        #on récupère les instances user & order pour ensuite pouvoir les passer à la view en @user
        @user = user 
        @order = order
    
        #on définit une variable @url qu'on utilisera dans la view d’e-mail
        @url  = 'http://bardic-reveries.com/login' 
    
        # c'est cet appel à mail() qui permet d'envoyer l’e-mail en définissant destinataire et sujet.
        mail(to: @user.email, subject: "Merci pour votre rêveries N° #{@order.id} !") 
 

      end
end
