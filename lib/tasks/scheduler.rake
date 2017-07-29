desc "This task is called by the Heroku scheduler add-on"
task :take_measures => :environment do
  puts "Take measures ..."

  require 'mqtt'
  require 'uri'

  # Create a hash with the connection parameters from the URL
  uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mosquitto://localhost:1883'
  conn_opts = {
    remote_host: uri.host,
    remote_port: uri.port,
    username: uri.user,
    password: uri.password,
  }



  # Subscribe to sensor/temperature
  Thread.new do
    MQTT::Client.connect(conn_opts) do |c|
      # The block will be called when you messages arrive to the topic
      c.get('sensor/temperature') do |topic, message|
        puts "#{topic}: #{message}"

        Test.create(nom: "#{topic}", valeur: "#{message}")

      end
    end
  end

  # Subscribe to sensor/temperature
  Thread.new do
    MQTT::Client.connect(conn_opts) do |c|
      # The block will be called when you messages arrive to the topic
      c.get('sensor/humidity') do |topic, message|
        puts "#{topic}: #{message}"

        Test.create(nom: "#{topic}", valeur: "#{message}")

      end
    end
  end

  sleep 5

  puts "done."

  exit

end

