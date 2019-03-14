client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "4XBgEbkPijm3QpGBiozpXbnNM"
  config.consumer_secret     = "l60uGl7JnyhqPqwOiNbvV7FlQo3ASZ3oEY70Vf7qi3M28KyusI"
  config.access_token        = "74724175-SLfC4HnI3nbzvHEG5Ls3hFKlORxRoDFhBDKtAmHlA"
  config.access_token_secret = "uWP3q2FUcCnG5g3B6Jj6estnCBgvPkZOjsM948T8ams6U"
end



# fromDate: (Time.now - 1.day) # Retorna os tweets a partir desta data.
# until: Time.now # Retorna os tweets até a data informada. (Default: now())
# include_entities: true # Retornar o nó "entities". (Default: false)
# since_id: 1546456 # Retorna somente os tweets com ID maior do que o informado (mais recentes).
# %23ruby = #ruby => Pesquisa pela hashtag
# duas palavras => Pesquisa por qualquer uma das palavras
# "duas palavras" => Pesquisa pela correspondência exata da expressão


client.search('%23ruby -rt', lang: "pt", result_type: "recent").count
