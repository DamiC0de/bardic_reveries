require 'rest_client'
require 'obscenity'
class Story < ApplicationRecord
    belongs_to :user
    
    def generate_content
        # Déterminer le nombre de jetons à générer en fonction de l'âge
        case self.age
        when 0..3
          max_tokens = 800  # Testez et ajustez ce nombre pour obtenir environ 300 caractères
        when 4..5
          max_tokens = 1200  # Testez et ajustez ce nombre pour obtenir environ 600 caractères
        else
          max_tokens = 3600  # Testez et ajustez ce nombre pour obtenir environ 800 caractères
        end
      
        input = generate_openai_input
      
        response = RestClient.post(
          "https://api.openai.com/v1/engines/text-davinci-003/completions",
          {
            "prompt" => input,
            "max_tokens" => max_tokens,
            "temperature" => 0.7
          }.to_json,
          {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}"
          }
        )
      
        story_text = JSON.parse(response.body)['choices'][0]['text']

        # Enlever les espaces blancs au début et à la fin
        story_text = story_text.strip

        # Extraire le titre de l'histoire du texte
        self.title, story_text = story_text.split("\n", 2)
      
        # Générer une conclusion en utilisant la dernière phrase comme invite
        last_sentence = story_text.split(". ").last
        conclusion_prompt = last_sentence + " FIN."
      
        response = RestClient.post(
          "https://api.openai.com/v1/engines/text-davinci-003/completions",
          {
            "prompt" => conclusion_prompt,
            "max_tokens" => 100,  # Vous pouvez ajuster ce nombre selon la longueur souhaitée pour la conclusion
            "temperature" => 0.7
          }.to_json,
          {
            "Content-Type" => "application/json",
            "Authorization" => "Bearer #{ENV['OPENAI_API_KEY']}"
          }
        )
      
        conclusion = JSON.parse(response.body)['choices'][0]['text']
        
        story_text + conclusion
      end
      

      
    def generate_openai_input
      print first_character
      print "Raconte moi une histoire pour un enfant de #{age} ans dont le thème est #{theme}, le personnage principal s'appelle #{Obscenity.sanitize(first_character)}, le personnage secondaire s'appelle #{Obscenity.sanitize(secondary_character)} et son objet fétiche s'appelle #{Obscenity.sanitize(fav_object)}. Commence par le titre de l'histoire."
        "Raconte moi une histoire pour un enfant de #{age} ans dont le thème est #{theme}, le personnage principal s'appelle #{Obscenity.sanitize(first_character)}, le personnage secondaire s'appelle #{Obscenity.sanitize(secondary_character)} et son objet fétiche s'appelle #{Obscenity.sanitize(fav_object)}. Commence par le titre de l'histoire."
    end
  end