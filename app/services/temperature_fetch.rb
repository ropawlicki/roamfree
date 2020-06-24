class TemperatureFetch

  def self.call(city)
    params = { q: city, appid: ENV['OPENWEATHER_API_KEY'], units: "metric" }
    begin
      response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather", query: params)
      temperature = response.fetch("main").fetch("temp")
    rescue StandardError => e
      if response && response["message"]
        p "ERROR: #{response["message"]}"
      else
        p "ERROR: #{e.message}"
      end
    end
    temperature
  end

end