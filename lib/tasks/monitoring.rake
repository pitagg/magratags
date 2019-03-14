desc 'Monitora as redes sociais em background'
namespace :monitoring do
  desc 'Executa as buscas configuradas e armazena os dados recebidos'
  task run: :environment do
    credentials = Credential.where(provider: :twitter)
    attempt = 0
    Search.by_priority.each do |search|
      begin
        credential = credentials[attempt]
        if credential.present?
          tweets = search.run(credential)
          next if tweets.count <= 0
          tweets.each{|tweet| Post.create_from_tweet(tweet)}
        end
      rescue => e
        attempt += 1
        retry unless attempt >= credentials.size
      end
    end
  end
end
