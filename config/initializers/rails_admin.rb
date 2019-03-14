RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

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

  config.parent_controller = '::ApplicationController'

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
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end

  config.model 'User' do
    weight 1
    list do
      fields :name, :email, :created_at
    end

    show do
      field :name
      field :email
      field :created_at
    end

    edit do
      field :name
      field :email
      field :password
      field :password_confirmation
    end
  end

  config.model 'Credential' do
    weight 2
    list do
      fields :provider, :name
    end

    show do
      fields :provider, :name, :consumer_key, :consumer_secret, :access_token, :access_token_secret
      field :user
    end

    edit do
      field :provider, :enum do
        enum do
          [['Twitter', :twitter]]
        end
      end
      fields :name, :consumer_key, :consumer_secret, :access_token, :access_token_secret
      field :user_id, :hidden do
        default_value do
          bindings[:view]._current_user.id
        end
      end
    end
  end

  config.model 'Search' do
    weight 3
    list do
      fields :name, :expression, :ignore_rt, :created_at, :synced_at
    end

    show do
      fields :id, :name, :expression, :ignore_rt
      field :created_at
      field :synced_at
    end

    edit do
      fields :name, :expression, :ignore_rt
    end
  end
end
