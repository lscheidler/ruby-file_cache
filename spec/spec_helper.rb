$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require "file_cache"
require 'delorean'

def file_cache_open
  FileCache.open do
    Time.now
  end
end

def file_cache_open_marshal
  FileCache.open format: :marshal do
    Time.now
  end
end
