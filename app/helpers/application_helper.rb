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
    content_tag :ul, class: 'top-user-area-list list list-horizontal list-border' do
      if current_user
        render 'layouts/user_link'
      else
        content_tag :li do
          link_to 'Log in', '#', data: { toggle: 'modal', target: '#myModal' }
        end
      end
    end
  end
end
