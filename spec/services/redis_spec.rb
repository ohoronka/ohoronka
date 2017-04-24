require 'rails_helper'

RSpec.describe 'RedisStore' do
  it 'checks cache' do
    i = rand(10000)
    Rails.cache.write('checks_cache', i)
    expect(Rails.cache.read('checks_cache')).to eq(i)
  end

  it 'checks that the cache clears' do
    expect(Rails.cache.read('checks_cache')).to be_nil
  end
end
