class NovaPoshtaService
  attr_reader :model

  class Error < StandardError
  end

  def initialize
    @model = NovaPoshta::Model::Address.new
  end

  def areas
    @areas ||= Rails.cache.fetch([:nova_poshta, :areas], expire_in: 1.day) do
      raise_if_error(model.areas).body['data']
    end
  end

  def cities
    @cities ||= Rails.cache.fetch([:nova_poshta, :cities], expire_in: 1.day) do
      raise_if_error(model.cities).body['data']
    end
  end
  
  def cities_by(options)
    filter(cities, options)
  end

  def warehouses(city_ref)
    raise 'city_ref cannot be nil' if city_ref.nil?
    @warehouses ||= {}
    @warehouses[city_ref] ||= Rails.cache.fetch([:nova_poshta, :warehouses, city_ref], expire_in: 1.day) do
      raise_if_error(model.warehouses(city_ref)).body['data']
    end
  end

  def filter(collection, options)
    result = collection
    result = result.select{|i| i['Ref'] == options[:ref]} if options[:ref]
    result = result.select{|i| i['Description'].match?(/\A#{options[:description]}/i) || i['DescriptionRu'].match?(/\A#{options[:description]}/i)} if options[:description]
    result
  end

  def raise_if_error(response)
    raise Error, response.body['errors'].join(',') unless response.body['success']
    response
  end

end
