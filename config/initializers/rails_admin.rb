RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    config.authorize_with do
      authenticate_or_request_with_http_basic('Access Denied') do |username, password|
        username == 'admin' && password == 'password'
      end
    end

    config.model User do
      list do
        exclude_fields :reset_password_sent_at, :remember_created_at, :authentication_token, :confirmation_token,
                       :current_sign_in_ip, :last_sign_in_at, :raw_oauth_data, :reset_password_token, :sign_in_count,
                       :current_sign_in_at, :last_sign_in_ip, :sent_messages, :received_messages, :updated_at,
                       :created_at, :messages_read_at
      end

      edit do
        include_fields :email, :password, :password_confirmation, :first_name, :last_name, :birth_date, :blocked
      end
    end
  end
end
