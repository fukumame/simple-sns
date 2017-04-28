module HelperMethods
  def login_with(email, password)
    post user_session_path, params: {user: {email: email, password: password}}
    follow_redirect!
  end
end