class API < Grape::API
  format :json

  rescue_from ActiveRecord::RecordInvalid do |error|
    error!({errors: error.record.errors.messages}, 422)
  end

  resource :songs do
    params do
      requires :title, type: String
      optional :text, type: String
    end
    post do
      Song.create!(
        title: params[:title],
        text: params[:text]
      )
    end
  end

  add_swagger_documentation
end
