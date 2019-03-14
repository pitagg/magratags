desc 'Monitora as redes sociais em background'
namespace :monitoring do
  desc 'Executa as buscas configuradas e armazena os dados recebidos'
  task run: :environment do
    credentials = Credential.where(provider: :twitter)
    attempt = 0
    Search.by_priority.each do |search|
      begin
        credential = credentials[attempt]
        search.run_and_import(credential) if credential.present?
      rescue Twitter::Error::TooManyRequests
        # Excedeu o limite de requisições da API, então tenta continuar com a próxima credencial cadastrada.
        attempt += 1
        retry unless attempt >= credentials.size
      rescue Twitter::Error::BadRequest
        # Bad Authentication data
        # TODO: Marcar credencial como inválida para não ser utilizada novamente.
        attempt += 1
        retry unless attempt >= credentials.size
      rescue => error
        Rails.logger.error [error.class, error.message].join(': ')
        Rails.logger.error error.backtrace.join("\n")
      end
    end
  end
end
