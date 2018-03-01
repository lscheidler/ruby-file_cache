require "spec_helper"

describe FileCache do
  before(:all) do
    begin
      FileCache.clean
    rescue Errno::ENOENT
      # ignore missing cache file
    end
    @initial_data = file_cache_open
    @initial_data_marshal = file_cache_open_marshal
  end

  it "has a version number" do
    expect(FileCache::VERSION).not_to be nil
  end

  describe 'open' do
    it 'loads cached data' do
      Delorean.jump(60) do
        expect(file_cache_open).to eq(@initial_data.to_s)
      end
    end

    it 'with variants creates new cache file' do
      data = FileCache.open variants: 'variant' do
        Time.now
      end

      expect(data).not_to eq(@initial_data.to_s)
    end

    it 'runs block again, if lifetime is expired' do
      Delorean.jump(60*60*24) do
        expect(file_cache_open).not_to eq(@initial_data.to_s)
      end
    end
  end

  describe 'open(format: :marshal)' do
    it 'loads cached data' do
      Delorean.jump(60) do
        expect(file_cache_open_marshal).to eq(@initial_data_marshal)
      end
    end
  end

  describe 'clean' do
    it 'removes cache file' do
      data = file_cache_open
      FileCache.clean
      expect(file_cache_open).not_to eq(data.to_s)
    end
  end
end
