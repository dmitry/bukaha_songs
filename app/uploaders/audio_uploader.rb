require "streamio-ffmpeg"

class AudioUploader < Shrine
  MAX_FILESIZE = 20.megabytes
  MIME_TYPES =  # validate type

  #plugin :pretty_location
  plugin :instrumentation
  plugin :validation_helpers
  plugin :cached_attachment_data
  plugin :restore_cached_data
  plugin :determine_mime_type
  plugin :add_metadata

  Attacher.validate do
    validate_size 1..20.megabytes
    validate_mime_type_inclusion %w(
      audio/mpeg
      audio/mp3
      audio/ogg
    ).freeze
  end

  add_metadata do |io|
    movie = Shrine.with_file(io) do |file|
      FFMPEG::Movie.new(file.path)
    end

    {
      "duration" => movie.duration,
      "bitrate" => movie.bitrate,
      "size" => movie.size,
      "audio_stream" => movie.audio_stream,
      "audio_codec" => movie.audio_codec,
      "audio_sample_rate" => movie.audio_sample_rate,
      "audio_channels" => movie.audio_channels,
    }
  end

  def generate_location(io, record:, metadata:, **options)
    extension = ".#{io.extension}" if io.is_a?(UploadedFile) && io.extension
    extension ||= File.extname(metadata["filename"].to_s).downcase
    "compositions/original/#{record.generate_identifier}#{extension}"
  end
end