require 'sinatra/lib/sinatra'

module Points
	def self.data
		@@data ||= initial_data
	end
	
	def self.initial_data
		[ OpenStruct.new(:date => '2008-01-01 13:57:21', :value => 42) ]
	end
end

get '/' do
	erb :index
end

get '/data.xml' do
	erb :data, :locals => { :points => Points.data }
end

post '/' do
	Points.data << OpenStruct.new(:date => (params[:date] || Time.now.to_s), :value => params[:value])
	"ok"
end
