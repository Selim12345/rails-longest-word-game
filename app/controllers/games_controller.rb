require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase

    response = open("https://wagon-dictionary.herokuapp.com/#{@word}")
    json = JSON.parse(response.read)

    if @word.chars.all? { |letter| @word.count(letter) <= params[:letters].split(" ").count(letter) }
      if json['found'] == true
        @message = "well done"
      else
        @message = "not an english word"
      end
    else
      @message = "not in the grid"
    end

  end
end
