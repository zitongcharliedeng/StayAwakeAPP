class CronsController < ApplicationController
  require 'rest-client'

  def start
    user_id = "fillIn"
    access_token = "fillIn"
    date = Time.now.strftime("%Y/%m/%d") # date = YYYY/MM/DD
    res = RestClient.get("https://api.fitbit.com/1.2/user/#{user_id}/sleep/date/#{date}.json", headers={authorization: "Bearer #{access_token}"})
    p res.to_yaml
  end
end
