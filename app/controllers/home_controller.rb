class HomeController < ApplicationController
    def index
        @stories = []
        Story.all.each do |story|
          if story.is_public
            @stories << story
          end
        end
      end
end
