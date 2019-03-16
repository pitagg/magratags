class Search < ApplicationRecord
  has_and_belongs_to_many :posts
  validates_presence_of :name, :expression

  scope :by_priority, ->{ order('synced_at asc NULLS FIRST, created_at asc') }

  # Executa a busca na API do Twitter e retorna os tweets encontrados.
  #TODO: Cada Search deve ser vinculado a 1 ou mais Providers.
  #TODO: Busca pela credencial deve ser self.provider,credentials.order(:used_at).first (mais tempo sem ser usada = chance de exceder limites da API)
  def run(credential=nil)
    client = credential.try(:client) || Credential.first.try(:client)
    return unless client.is_a?(Twitter::REST::Client)
    expression = self.expression.gsub('#', '%23') # Necessário para Twitter executar corretamente a busca. %23 é o URL encode para '#'.
    expression << ' -rt' if self.ignore_rt # Instrução para não receber retweets.
    options = {lang: "pt", result_type: "recent", include_entities: true} # TODO: Permitir que o usuário selecione o idioma desejado
    options.merge!(since_id: self.last_tweet_id) if self.last_tweet_id.present?
    client.search(expression, options)
  end

  # Busca por tweets na API do Twitter e os importa para o Banco de Dados
  def run_and_import(credential=nil)
    tweets = self.run(credential)
    last_tweet_id = self.last_tweet_id.to_i
    tweets.each do |tweet|
      post = Post.create_from_tweet(tweet)
      post.searches << self
      last_tweet_id = post.tweet_id if post.tweet_id.to_i > last_tweet_id.to_i
    end
    self.update synced_at: Time.now, last_tweet_id: last_tweet_id
  end

  def self.for_select
    self.all.map{|search| [search.name, search.id]}
  end
end
