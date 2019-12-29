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
      songs = Song.title_like(params[:title])
      present songs, with: API::Entities::Song
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


  module Entities
    class Song < Grape::Entity
      expose :id
      expose :title
      expose :text
      expose :chords?, as: :has_chords
      expose :lyrics
      expose :lyrics_with_chords

      expose :compositions, using: 'API::Entities::Composition'
    end
    class Composition < Grape::Entity
      expose :id
      expose :identifier
      #expose :audio_url
      expose :authors, using: 'API::Entities::Author'
      expose :instruments, using: 'API::Entities::Instrument'
    end
    class Author < Grape::Entity
      expose :id
      expose :name
    end
    class Instrument < Grape::Entity
      expose :id
      expose :name
    end
  end
end
