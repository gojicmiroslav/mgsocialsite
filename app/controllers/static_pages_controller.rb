class StaticPagesController < ApplicationController

  #layout "static_layout", except: :home
  #layout :determine_layout
  
  def home
  	if user_signed_in?
  		@micropost = current_user.microposts.build 
  		@feed_items = current_user.feed.paginate(page: params[:page])

      render layout: "application"
    else
      render layout: "front_layout"
		end 
  end

  def help
    render layout: "static_layout"
  end

  def about
  end

  def contact
  end

  private

  def determine_layout
    case action_name
      when :help, :about, :contact
        "static_layout"
      when :home  
        if user_signed_in?
          "application"
        else 
          "front_layout"
        end
      end
    end
  
end
