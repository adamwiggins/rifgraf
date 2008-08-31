require 'sinatra/lib/sinatra'

$LOAD_PATH.unshift 'sequel/lib'
require 'sequel/lib/sequel'

module Points
	def self.data
		@@data ||= make
	end

	def self.make
		if ENV['DATABASE']
			db = connect_postgres
		else
			db = connect_sqlite
		end
		make_table(db)
	end

	def self.make_table(db)
		db.create_table :points do
			varchar :graph, :size => 32
			varchar :value, :size => 32
			datetime :date
		end
		db[:points]
	end

	def self.connect_sqlite
		Sequel.sqlite
	end

	def connect_postgres
		Sequel.connect("postgres://#{ENV['ROLE']}:#{ENV['PASSWORD']}@#{ENV['HOST']}:5432/#{ENV['DATABASE']}")
	end
end

get '/graphs/:id' do
	erb :graph, :locals => { :id => params[:id] }
end

get '/graphs/:id/amstock_settings.xml' do
	erb :amstock_settings, :locals => { :id => params[:id] }
end

get '/graphs/:id/data.csv' do
	erb :data, :locals => { :points => Points.data.filter(:graph => params[:id]).reverse_order(:date) }
end

post '/graphs/:id' do
	Points.data << { :graph => params[:id], :date => (params[:date] || Time.now), :value => params[:value] }
	"ok"
end
