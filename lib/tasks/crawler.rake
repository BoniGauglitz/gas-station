require 'nokogiri'
require 'open-uri'
require 'pp'

desc 'Fetch Gas Stations'
namespace :crawler do
  task fetch: :environment do
    url = 'http://www.postodegasolina.org/posto-em/sp/sao-paulo/'

    doc = Nokogiri::HTML(open(url))
    doc.css('.pin').map do |item|
      name = item.css('.titulo').text.strip
      street = item.css('.endereco').text.strip
      city = item.css('.localizacao').text.strip
      price = item.css('.preco').text.strip

      address = "#{street}, #{city}"

      lat = item.at_css('.posto-geo-lat')['value']
      long = item.at_css('.posto-geo-lng')['value']

      if(lat.length == 0)
        lat = 0
        long = 0
      end

      station = Station.new
      station.name = name
      station.address = address
      station.gas_price = price
      station.coordinate = {
        longitude: long,
        latitude: lat
      }

      station.save
    end
  end
end
