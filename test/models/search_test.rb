require 'test_helper'

class SearchTest < ActiveSupport::TestCase
  test "search name cant be blank" do
    search = Search.new
    search.valid?
    assert search.errors.details[:name].map(&:values).flatten.include?(:blank)
  end

  test "search expression cant be blank" do
    search = Search.new
    search.valid?
    assert search.errors.details[:expression].map(&:values).flatten.include?(:blank)
  end

  # Comentado para não expor as credenciais de acesso à API.
  # TODO: Colocar as credenciais em arquivo local ignorado pelo git para viabilizar o teste com segurança.
  # test 'run should be return a Twitter::SearchResults' do
  #   assert Search.first.run.is_a?(Twitter::SearchResults)
  # end
end
