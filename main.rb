require 'sinatra/lib/sinatra'

require 'rubygems'
require 'sequel'

module Points
	def self.data
		@@data ||= make
	end

	def self.make
		db = Sequel.sqlite
		db.create_table :points do
			varchar :graph, :size => 32
			varchar :value, :size => 32
			varchar :date, :size => 32
		end
		db[:points]
	end
end

get '/graphs/:id' do
	erb :index, :locals => { :id => params[:id] }
end

get '/graphs/:id/data.xml' do
	erb :data, :locals => { :points => Points.data.filter(:graph => params[:id]) }
end

post '/graphs/:id' do
	Points.data << { :graph => params[:id], :date => (params[:date] || Time.now.strftime("%Y-%m-%d %H:%I:%S")), :value => params[:value] }
	"ok"
end
