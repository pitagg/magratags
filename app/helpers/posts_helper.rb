module PostsHelper
  def format_post_text(text)
    text = sanitize(text) # Elimina tags e possíveis tentativas de injection.
    text = simple_format text # Transformar quebra de linha \n em <br>
    text = auto_link text, html: {target: :_blank} # Transforma URLs em <a>
  end
end
