class CronsController < ApplicationController
  require 'rest-client'

  # This only needs to be called the first time we add a new user
  # We will call it manually for now (e.g. via postman) to store their first set of access_token and access_token credentials in DB
  # Once this first set of tokens is stored, all subsequent attempts to authenticate will use the tokens stored in DB
  def new_user
    user_id = parse_param(params, "user_id")
    access_token = parse_param(params, "access_token")
    refresh_token = parse_param(params, "refresh_token")
    access_token_expiry = parse_param(params, "access_token_expiry")

    @user = User.new(user_id: user_id, access_token: access_token, refresh_token: refresh_token, access_token_expiry: access_token_expiry)
    if @user.save
        p "🎉🎉🎉 User successfully saved 🎉🎉🎉"
    else
        p "There was a problem saving this user"
    end
  end
    
  def start
    user_id = "B7VF69"
    @user = User.find_by(user_id: user_id)
    access_token = @user.session_token
    date = Time.now.strftime("%Y-%m-%d") # date = YYYY-MM-DD

    res = JSON.parse(RestClient.get("https://api.fitbit.com/1.2/user/#{user_id}/sleep/date/#{date}.json", headers={authorization: "Bearer #{access_token}"}))
    p res
    if (res.key?(:meta)) # res should have a meta key when sleep logs are processing (requested during a sleep still ongoing) see "metaresponse" in https://dev.fitbit.com/build/reference/web-api/sleep/get-sleep-log-by-date/
      p "USER IS ASLEEP RIGHT NOW"
    end
    
  end

  private
  def parse_param(params, key)
    param = params[key]
    if !param || param == ""
        raise "missing param #{key}"
    end

    return param
  end

end
