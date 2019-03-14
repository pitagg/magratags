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

  test 'run should be return a Twitter::SearchResults' do
    assert Search.first.run.is_a?(Twitter::SearchResults)
  end
end
