require 'digest'

require_relative "file_cache/version"

# provides file caching mechanism for data structures
module FileCache
  # return data from cache file or generate new cache file with data from block
  #
  # @param lifetime [Integer] lifetime of cached data
  # @param variants [String] variant to add to filename, if multiple cache files are necessary
  # @param format [Symbol] format to save cache data, available formats: :json, :marshal
  # @param force_refresh [Bool] force refresh of cached data
  # @yield block, which returns data, which is going to be cached
  # @return [Object] data from cache or block
  def self.open lifetime: 24*60, variants: nil, format: :json, force_refresh: false
    file_extension = '.data'
    case format
    when :json
      require 'json'
      file_extension = '.json'
    when :marshal
    else
      raise ArgumentError.new 'No format ' + format.to_s + ' implemented.'
    end

    filename = '/tmp/cache.' + Digest::MD5::hexdigest($0 + variants.to_s) + file_extension
    begin
      data = if not force_refresh and File.exist? filename and (Time.now.to_i - File.mtime(filename).to_i) < lifetime * 60
        content = File.read(filename)
        case format
        when :json
          JSON::parse(content)
        when :marshal
          Marshal.load(content)
        end
      end
    rescue Exception
      # loading cache file failed
      #warn 'Problem with loading cache file'
      data = nil
    end

    # if data not set, run block
    unless data
      data = yield
      File.open(filename, 'w') do |io|
        content = nil
        case format
        when :json
          content = data.to_json
        when :marshal
          content = Marshal.dump(data)
        end
        io.print(content)
      end
    end
    data
  end

  # delete cache file
  #
  # @param variants [String] variant to add to filename
  # @param format [Symbol] format to save cache data, available formats: :json, :marshal
  def self.clean variants: nil, format: :json
    file_extension = '.data'
    case format
    when :json
      require 'json'
      file_extension = '.json'
    when :marshal
    else
      raise ArgumentError.new 'No format ' + format.to_s + ' implemented.'
    end

    filename = '/tmp/cache.' + Digest::MD5::hexdigest($0 + variants.to_s) + file_extension
    File.delete filename
  end
end
