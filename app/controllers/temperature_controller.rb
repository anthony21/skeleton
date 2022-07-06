class TemperatureController < ApplicationController
 def index
   @t = Temperature.first
   @zip = params[:zip_code]
   @units = "°C"
  
   get
 end

 def get
   require 'net/http'
   require 'json'
   @key ='f05b22a3bee94fd08ca222356220407'
   @url = "https://api.weatherapi.com/v1/forecast.json?key="+@key+"&q="+@zip+"&days=0"
   @uri = URI(@url)
   @response = Net::HTTP.get(@uri)

   unless @response['error'] != nil 
    build_response
   else 
     encountered_error
   end
 end

 def update
  @temp = Temperature.first

  @temp.cold = params[:cold] 
  @temp.warm = params[:warm]
  @temp.hot = params[:hot] 
  @temp.save
  
  if @temp.save
    redirect_to home_path
  else
    return "Error"
  end
 end
 
 def encountered_error
   @msg = "Invalid zip code "
   @output = 'error'
   @country = 'error'
 end

 def build_response
   @output = JSON.parse(@response)
   @degrees = @output['current']['temp_c']
   @country = @output['location']['region']
   @msg = "Todays High in "
   @d = @degrees

   case(@d >1)
   when(@d <= @t.cold.to_i)
      @forecast = "cold"
   when(@d >= @t.cold.to_i && @d <= @t.warm.to_i)
      @forecast = "warm"
   when(@d >= @t.hot.to_i)
      @forecast = "Hot"
   else
      @forecast = "unknown"
   end
 end

end