desc "This task is called by the Heroku scheduler add-on"
task :update_listes => :environment do
  puts "Updating listes..."

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

        #begin

        #    con = PG.connect(:dbname => "demo_IOT_production", :user => "demo_IOT", :password => ENV['DEMO_IOT_DATABASE_PASSWORD'])
        #    con.exec "INSERT INTO tests(nom, valeur, created_at, updated_at)
        #    VALUES('#{topic}', '#{message}', '#{Time.now}', '#{Time.now}')"

        #rescue PG::Error => e

        #    puts e.message

        #ensure

        #    con.close if con

        #end

      end
    end
  end

  # Subscribe to sensor/temperature
  Thread.new do
    MQTT::Client.connect(conn_opts) do |c|
      # The block will be called when you messages arrive to the topic
      c.get('sensor/humidity') do |topic, message|
        puts "#{topic}: #{message}"
        #test = Test.new(nom: "#{topic}", valeur: "#{message}")
        #test.save

      end
    end
  end

  sleep 5

  puts "done."

  exit

end

