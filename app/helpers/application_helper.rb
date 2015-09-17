module ApplicationHelper
  def sign_in_provider
    {
      facebook: { name: 'Facebook', class: 'btn-facebook', icon_class: 'fa-facebook' },
      google_oauth2: { name: 'Google', class: 'btn-googleplus', icon_class: 'fa-google-plus' }
    }
  end

  def signin_path(provider)
    redir_path = { origin: request.env['PATH_INFO'] }.to_query
    "/auth/#{provider}?#{redir_path}"
  end

  def login_signout_profile_helper
      if current_user
        render 'layouts/user_link'
      else
        content_tag :li do
          link_to 'Log in', '#', data: { toggle: 'modal', target: '#myModal' }
        end
      end
  end

  def alert_script
    if flash[:danger] || flash[:message]
      content_tag :script, type: "text/javascript" do
        alert_message
      end
    end
  end

  def turn_model_error_message_hash_to_readable_string(flash_message)
    if flash_message.is_a? Array
      flash_message.each do |message|
        content_tag :li do
          message.to_s
        end
      end
    end
  end

  def alert_message
    flash_message = flash[:message] || flash[:danger]
    if flash_message.is_a? String
      flash_content =  "#{flash_message}"
    else
      flash_content = "#{turn_model_error_message_hash_to_readable_string(flash_message)}"
    end
    # flash_content =  "#{flash_message}" : turn_model_error_message_hash_to_readable_string(flash_message)
    "toastr.warning(\'#{flash_content}\')".html_safe
    # flash[:message] || flash[:danger]
  end
end
