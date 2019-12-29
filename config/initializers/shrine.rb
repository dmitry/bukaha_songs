if Rails.env.test?
  require "shrine/storage/memory"

  Shrine.storages = {
    cache: Shrine::Storage::Memory.new,
    store: Shrine::Storage::Memory.new
  }
else
  require "shrine/storage/file_system"

  Shrine.storages = {
    cache: Shrine::Storage::FileSystem.new("public", prefix: "system/cache"),
    store: Shrine::Storage::FileSystem.new("public", prefix: "system")
  }
end

Shrine.plugin :activerecord

Shrine.logger = ActiveSupport::TaggedLogging.new(Logger.new('log/shrine.log'))
