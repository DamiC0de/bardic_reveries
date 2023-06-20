class StoriesController < ApplicationController
    before_action :authenticate_user!

    def index
      @stories = current_user.stories
    end
      
  
    def new
      @story = Story.new
    end
  
    def create
        @story = current_user.stories.new(story_params)
        @story.content = @story.generate_content
        if @story.save
          redirect_to @story
        else
          render 'new'
        end
      end
      
  
    def show
      @story = Story.find(params[:id])
      @openai_input = @story.generate_openai_input
    end

    def update
        @story = Story.find(params[:id])
        if @story.update(story_params)
          redirect_to stories_path, notice: 'Votre histoire a été enregistrée avec succès.'
        else
          render :show
        end
      end

      def destroy
        @story = Story.find(params[:id])
        @story.destroy
    
        redirect_to stories_path, notice: 'L\'histoire a été supprimée avec succès.'
      end  
      
  
    private
  
    def story_params
      params.require(:story).permit(:theme, :age, :first_character, :secondary_character, :fav_object, :is_public)
    end

    
  end
  