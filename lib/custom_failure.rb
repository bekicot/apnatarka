class CustomFailure < Devise::FailureApp
  def redirect_url
    if request.referrer&.include? new_user_session_path.split("/").last
       root_path
    else
       root_path
    end
  end

  def respond
    if http_auth?
      redirect
    else
      redirect
    end
  end
end
