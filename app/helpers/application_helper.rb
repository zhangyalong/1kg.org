# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def nav_menu(text, url, session_name)
    if session[:nav] == session_name
      return link_to(text, url, :class => "now")
    else
      return link_to(text, url)
    end
  end
  
  def title_suffix
    "&middot;&nbsp; &middot;&nbsp; &middot;&nbsp; &middot;&nbsp; &middot;&nbsp; &middot;&nbsp;"
  end

	def mailbox_nav_menu
		content_for "sidebar" do
			render :partial => "layouts/mailbox"
		end
	end

	def customize_paginate(value)
		will_paginate value, :previous_label => '<<',
												 :next_label => '>>'
	end
end
