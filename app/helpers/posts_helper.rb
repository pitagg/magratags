module PostsHelper
  # Elimina possíveis entradas HTML do texto, transforma quebras de linha de texto em HTML e torna URLs em links clicáveis.
  # @param text (String) o texto a ser convertido.
  # @return (String) o HTML gerado.
  def format_post_text(text)
    text = sanitize(text) # Elimina tags e possíveis tentativas de injection.
    text = simple_format text # Transformar quebra de linha \n em <br>
    text = auto_link text, html: {target: :_blank} # Transforma URLs em <a>
  end
end
