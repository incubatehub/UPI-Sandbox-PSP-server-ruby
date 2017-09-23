require "roda"
require "rack"
require 'json'
require 'unirest'
require 'thin'
require 'rack/cors'
require 'slim'
require 'slim/include'
require 'nobrainer'
require 'sequel'
require 'faye'
require 'faye/websocket'
require 'kaminari-nobrainer'
ENV["secret"]=SecureRandom.hex(5).to_s
Sequel.extension :migration
cur_dir = File.dirname(__FILE__)
log_file=File.expand_path(File.join(cur_dir,'logs','errors.log'))
LOGGER=Logger.new(log_file,'weekly')
LOGGER.level=Logger::ERROR
LOGGER.datetime_format="%d-%b-%y %I:%M:%S %p - %Z"
DB =  Sequel.connect('sqlite://db/dummy_psp.db')
DB.extension(:pagination)
require_relative './migrations/all.rb'
require_relative './models/all.rb'
require_relative './routes/defaults.rb'
require_relative './routes/App.rb'

map '/' do
    run App.app
end

Faye::WebSocket.load_adapter('thin')
$communication = Faye::RackAdapter.new(
  :mount   => '/ws',
  :timeout => 25
)
map '/live' do
  run $communication
end

$communication.on(:subscribe) do |client_id, channel|

end
$communication.on(:unsubscribe) do |client_id, channel|

end
