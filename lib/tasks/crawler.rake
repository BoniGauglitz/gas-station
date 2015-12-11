require 'nokogiri'
require 'open-uri'
require 'pp'

desc 'Fetch Gas Stations'
namespace :crawler do
  task fetch: :environment do
    url = 'http://www.postodegasolina.org/posto-em/sp/sao-paulo/'

    doc = Nokogiri::HTML(open(url))
    doc.css('.pin').map do |item|
      street = item.css('.endereco').text.strip
      city = item.css('.localizacao').text.strip

      lat = item.at_css('.posto-geo-lat')['value']
      long = item.at_css('.posto-geo-lng')['value']

      if(lat.length == 0)
        lat = 0
        long = 0
      end

      attributes = {
        name: item.css('.titulo').text.strip,
        address: "#{street}, #{city}",
        gas_price: item.css('.preco').text.strip,
        coordinate: {
          longitude: long,
          latitude: lat
        }
      }

      station = Station.find_or_initialize_by({ name: attributes[:name] })
      station.update_attributes(attributes)
    end
  end
end
