module ApplicationHelper
  # Retorna as classes para estilizar o elemento de alerta com base no tipo de mensagem.
  # @param level (String, Symbol) o tipo de alerta.
  # @return (String) as classes a serem incluídas no elemento HTML.
  def flash_classes(level)
    case level.to_s
      when 'notice' then "alert alert-info"
      when 'success' then "alert alert-success"
      when 'error' then "alert alert-danger"
      when 'alert' then "alert alert-warning"
    end
  end

  # Retorna as classes a serem utilizadas no elemento body, tais como o controller_name, a action_name e a classe relativa a imagem de fundo (aleatória).
  # @return  (String) as classes a serem incluídas no elemento body.
  def body_classes
    [controller_name, action_name, "bg#{(1..4).to_a.shuffle.first}"].join(' ')
  end

  # Gera o link de usuário com foto do gravatar para ser inserido na topbar.
  # @return (String) o código HTML gerado.
  def edit_user_link
    return unless current_user.present? && current_user.email.present?
    link_to edit_user_registration_path do
      html = []
      html << image_tag("#{(request.ssl? ? 'https://secure' : 'http://www')}.gravatar.com/avatar/#{Digest::MD5.hexdigest current_user.email}?s=30", alt: '') if RailsAdmin::Config.show_gravatar
      html << content_tag(:span, current_user.email)
      html.join.html_safe
    end
  end
end
