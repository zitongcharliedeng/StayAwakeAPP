class CronsController < ApplicationController
  require 'rest-client'

  def start
    user_id = "fillIn"
    access_token = "fillIn"
    date = Time.now.strftime("%Y/%m/%d") # date = YYYY/MM/DD
    res = JSON.parse(RestClient.get("https://api.fitbit.com/1.2/user/#{user_id}/sleep/date/#{date}.json", headers={authorization: "Bearer #{access_token}"}))
    p ('***RESPONSE:' + res)
    if (res.key?(:meta)) # res should have a meta key when sleep logs are processing (requested during a sleep still ongoing) see "metaresponse" in https://dev.fitbit.com/build/reference/web-api/sleep/get-sleep-log-by-date/
      p "USER IS ASLEEP RIGHT NOW"
    end
    
  end
end
