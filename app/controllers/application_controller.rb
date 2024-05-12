require 'rest-client'
require 'json'

class ApplicationController < ActionController::API
    def getcity
        if params[:city] != ""
            city = params[:city]
            response = RestClient.get 'https://search.reservamos.mx/api/v2/places', {params: {q: city}}
            puts response.code
            if response.code == 201
                json_object = JSON.parse(response)
                json_string = "["
                for ciudad in json_object
                    if ciudad["result_type"] == "city"
                        json_string+= '{"city_name":"' + ciudad["city_name"] +'","latitud":"' + ciudad["lat"] +'","longitud":"' + ciudad["long"] +'"},'
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
                    
                    response_wheather = RestClient.get 'https://api.openweathermap.org/data/2.5/onecall', {params: {lat: ciudad["latitud"], lon: ciudad["longitud"], exclude: "current,minutely,hourly,alerts", lang:"sp", units:"metric", appid:"a5a47c18197737e8eeca634cd6acb581" }}


                render json: { ciudades: json_object}
            else
                render json: {Error: "No hay ciudades"}
            end
        else
            render json: { ciudades: ""}
        end
    end
end
