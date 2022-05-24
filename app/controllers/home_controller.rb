class HomeController < ApplicationController
  def index
    require 'net/https'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=06504&distance=25&API_KEY=60C5BA67-517D-4D9A-B5AF-4AC171FF59AA'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)

    # Check for empty return result
    if @output.empty?
      @final_output = "Error"

    elsif !@output
      @final_output = "Error"

    else
      @final_output = @output[0]['AQI']
    end

    if @final_output == "Error"
      @api_color = "gray"
      @api_description = "You get no output information this time"
    elsif @final_output <= 50
      @api_color = "green"
      @api_description = "Enjoy your outdoors activitys"
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
      @api_description = "Its safe to be outside"
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
      @api_description = "It can be litle harder to breath"
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
      @api_description = "I would stay inside"
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
      @api_description = "Get inside fast"
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
      @api_description = "DANGER DANGER DONT GO OUT SIDE!"
    end
  end

  def zipcode
    @zip_query = params[:zipcode]
    if params[:zipcode] == ""
      @zip_query = "Hey you forgot to enter a zipcode!"
    elsif params[:zipcode]
      require 'net/https'
      require 'json'

      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode='+ @zip_query + '&distance=25&API_KEY=60C5BA67-517D-4D9A-B5AF-4AC171FF59AA'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)

      # Check for empty return result
      if @output.empty?
        @final_output = "Error"

      elsif !@output
        @final_output = "Error"

      else
        @final_output = @output[0]['AQI']
      end

      if @final_output == "Error"
        @api_color = "gray"
        @api_description = "You get no output information this time"
      elsif @final_output <= 50
        @api_color = "green"
        @api_description = "Enjoy your outdoors activitys"
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "yellow"
        @api_description = "Its safe to be outside"
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "orange"
        @api_description = "It can be litle harder to breath"
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "red"
        @api_description = "I would stay inside"
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "purple"
        @api_description = "Get inside fast"
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "maroon"
        @api_description = "DANGER DANGER DONT GO OUT SIDE!"
      end
    end
  end


end
