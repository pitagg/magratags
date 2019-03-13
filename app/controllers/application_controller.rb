class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_locale


  protected


    def set_locale
      # TODO: Locale e time zone devem vir das configurações do usuário.
      I18n.locale = 'pt-BR'
      Time.zone = 'Brasilia'
    end
end
