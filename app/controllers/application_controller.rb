class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :ignore_devise_actions


  protected

    # Define o idioma e timezone atuais.
    def set_locale
      # TODO: Locale e time zone devem vir das configurações do usuário.
      I18n.locale = 'pt-BR'
      Time.zone = 'Brasilia'
    end

    # Configura os parâmetros permitidos para entrada de dados pelo Devise.
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    end

    # Intercepta determinadas requisições controladas pelo Devise para fazer redirect (desta forma não é necessário sobrescrever os controllers do Devise).
    def ignore_devise_actions
      redirect_to rails_admin.edit_path(:user, current_user.id) if controller_name == 'registrations' && action_name == 'edit'
    end
end
