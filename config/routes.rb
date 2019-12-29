Rails.application.routes.draw do
  mount GrapeSwaggerRails::Engine => '/swagger'

  mount API => '/api'
end
