# running this file in the terminal will start a game of mastermind

require_relative 'game'
require 'bundler/inline'

gemfile true do
 source 'http://rubygems.org'
 gem 'colorize'
end

game = Game.new
game.play
