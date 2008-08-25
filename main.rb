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
		@@data ||= { }
	end
end

get '/graphs/:id' do
	erb :index, :locals => { :id => params[:id] }
end

get '/graphs/:id/data.xml' do
	erb :data, :locals => { :points => Points.data[params[:id]] }
end

post '/graphs/:id' do
	Points.data[params[:id]] ||= [ ]
	Points.data[params[:id]] << Point.new(params[:date], params[:value])
	"ok"
end
