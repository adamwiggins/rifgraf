require 'sinatra/lib/sinatra'

class Point
	attr_accessor :value, :date
	
	def initialize(date, value)
		@date = date || Time.now.strftime("%Y-%m-%d %H:%I:%S")
		@value = value
	end
end

module Points
	def self.data
		@@data ||= initial_data
	end
	
	def self.initial_data
		[ Point.new('2008-01-01 13:57:21', 42) ]
	end
end

get '/' do
	erb :index
end

get '/data.xml' do
	erb :data, :locals => { :points => Points.data }
end

post '/' do
	Points.data << Point.new(params[:date], params[:value])
	"ok"
end
