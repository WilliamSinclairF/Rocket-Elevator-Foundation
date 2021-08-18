module WatsonHelper
  require 'ibm_watson/authenticators'
  require 'ibm_watson/text_to_speech_v1'
  include IBMWatson
  include ZendeskHelper
  def greeting_message
    begin
    api_key = ENV['WATSON_API_KEY'] || 'no api key'
    authenticator =
      Authenticators::IamAuthenticator.new(apikey: api_key)
    text_to_speech = TextToSpeechV1.new(authenticator: authenticator)
    text_to_speech.service_url = "#{ENV['WATSON_URL']}"

    name = current_user.custom_label_method
    elevator_count = Elevator.count.to_s
    elevators_in_maintenance =
      Elevator.where(elevator_status: 'INACTIVE').count.to_s
    building_count = Building.count.to_s
    customer_count = Customer.count.to_s
    unprocessed_quotes_count =
      ticket_query('assignee%3Anone%20subject%3Aquote', 'search/count')['count']
    lead_count = Lead.count.to_s
    battery_count = Battery.count.to_s
    city_count = Address.pluck(:city).uniq.count

    spoken_text =
      "Hello #{name}. There are currently #{
        elevator_count
      } elevators deployed in the #{building_count} buildings of your #{
        customer_count
      } customers.
Currently, #{
        elevators_in_maintenance
      } elevators are not in Running Status and are being serviced.
You currently have #{unprocessed_quotes_count} quotes awaiting processing.
You currently have #{lead_count} leads in your contact requests.
#{battery_count} Batteries are deployed across #{city_count} cities.
Stay hydrated and have a great day."

    file_location = "public/uploads/user/#{current_user.id}"
      FileUtils.mkdir_p file_location
      File.open("#{file_location}/greetings.wav", 'wb') do |audio_file|
        response =
          text_to_speech.synthesize(
            text: "#{spoken_text}",
            accept: 'audio/wav',
            voice: 'en-GB_KateV3Voice'
          )
        audio_file.write(response.result)
        u = User.find(current_user.id)
        u.greeting_message = audio_file
        u.save
      end
  end
      rescue IBMWatson::ApiException => ex
      print "Method failed with status code #{ex.code}: #{ex.error}"
    end
end
