class API < Grape::API
  format :json

  rescue_from ActiveRecord::RecordInvalid do |error|
    error!({errors: error.record.errors.messages}, 422)
  end

  resource :songs do
    params do
      requires :title, type: String
    end
    get do
      Song.title_like(params[:title])
    end

    params do
      requires :title, type: String
      optional :text, type: String
    end
    post do
      Song.create!(params)
    end
  end

  resource :compositions do
    params do
      requires :song_id, type: String
      requires :audio, type: Rack::Multipart::UploadedFile
      optional :author_ids, Array[Integer]
      optional :instrument_ids, Array[Integer]
    end
    post do
      params.merge!(audio: ActionDispatch::Http::UploadedFile.new(params[:audio]))
      Composition.create!(params)
    end
  end

  resource :authors do
    params do
      requires :name, type: String
    end
    post do
      Author.create!(params)
    end
  end

  resource :instruments do
    params do
      requires :name, type: String
    end
    post do
      Instrument.create!(params)
    end
  end

  add_swagger_documentation
end
