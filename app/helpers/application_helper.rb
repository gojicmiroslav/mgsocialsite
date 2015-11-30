module ApplicationHelper

	# Returns  the full title on a per-page basis	
	def full_title(page_title = '')
		base_title = "MG Social Site"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def flash_class(type)
		case type
  		when 'notice'
  			'alert alert-success'
  		when 'alert'
  			'alert alert-danger'
  		else	
  			type
  		end
	end

	def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

end
