class TemperatureFetch

  def self.call(city)
    params = { q: city, appid: ENV['OPENWEATHER_API_KEY'], units: "metric" }
    begin
      response = HTTParty.get("https://api.openweathermap.org/data/2.5/weather", query: params)
      temperature = response.fetch("main").fetch("temp") if response["main"]
    rescue StandardError, HTTParty::Error => e
      Rails.logger.debug "ERROR: #{e.message}"
    end
    temperature
  end
end