require 'rest-client'
require 'json'

class ApplicationController < ActionController::API
    def getcity
        if params[:city] != ""
            city = params[:city]
            response = RestClient.get 'https://search.reservamos.mx/api/v2/places', {params: {q: city}}
            # puts response.code
            if response.code == 201
                json_object = JSON.parse(response)
                json_string = "["
                for ciudad in json_object
                    if ciudad["result_type"] == "city"
                        json_string+= '{"ciudad":"' + ciudad["city_name"] +'","latitud":"' + ciudad["lat"] +'","estado":"' + ciudad["state"] +'","longitud":"' + ciudad["long"] +'"},'
                    end
                end
                if json_string != "["
                    json_string = json_string.chop
                    json_string+="]"
                end
                # puts json_string.class
                json_cities = JSON.parse(json_string)

                #Parte de búsqueda de clima por ciudad para los 7 días de la semana
                for ciudad in json_cities          
                    response_wheather = RestClient.get 'https://api.openweathermap.org/data/2.5/forecast', {params: {lat:ciudad["latitud"] , lon:ciudad["longitud"], lang:"sp", units:"metric", appid:"fce130528c880e622fefde5bad9587e5" }}
                    json_weather = JSON.parse(response_wheather)
                    puts "holaaaa"
                    weather_array = []
                    n=0
                    for weather_list in json_weather["list"]
                        if weather_list["dt_txt"].include? "12:00:00"
                            # puts weather_list["main"]["temp_min"]
                            temp_min = weather_list["main"]["temp_min"].to_s
                            temp_max = weather_list["main"]["temp_max"].to_s
                            day = weather_list["dt_txt"].slice!(0..9)
                            weather_string = '{"dia":"'+ day +'","temperatura_minima":"' + temp_min +'°","temperatura_maxima":"' + temp_max +'°"}'
                            # puts weather_string
                            #weather_string = '{"t":"12°","t2":"45°"}'
                            json_weather_city = JSON.parse(weather_string)
                            # puts json_weather_city
                            weather_array[n] = json_weather_city
                            n = n+1
                        end
                    end
                    ciudad["temperatura"] = weather_array
                    #puts ciudad
                end

                render json: { ciudades: json_cities}
            else
                render json: {Error: "No hay ciudades"}
            end
        else
            render json: { ciudades: ""}
        end
    end
end
