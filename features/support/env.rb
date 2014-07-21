# Generated by cucumber-sinatra. (2014-07-21 16:57:43 +0100)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'lib/battleships.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = BattleShips

class BattleShipsWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  BattleShipsWorld.new
end
