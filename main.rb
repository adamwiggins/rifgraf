require 'rubygems'
require 'sinatra'

get '/' do
	erb :index
end

get '/data.xml' do
	a = <<EOXML
<?xml version="1.0" encoding="UTF-8"?>
<chart>
	<series>
		<value xid="0">2008-08-01</value>
		<value xid="1">2008-08-02</value>
		<value xid="2">2008-08-03</value>
	</series>
	<graphs>
		<graph gid="1">
			<value xid="0">5</value>
			<value xid="1">8</value>
			<value xid="2">7</value>
		</graph>
	</graphs>
</chart>
EOXML
end
