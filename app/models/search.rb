class Search < ApplicationRecord
  validates_presence_of :name, :expression
end
