class PostUserBatch
  def self.execute
    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['APP_ID']
      config.consumer_secret = ENV['APP_SECRET']
      config.access_token = User.first.access_token
      config.access_token_secret = User.first.access_token_secret
    end
    api_limit  = 100
    all_ids = User.first.post_users.pluck(:uid)
    all_ids.map!(&:to_i)
    all_ids.each_slice(api_limit) do |ids|
      post_users = client.users(ids)
      post_users.each do |post_user|
        _post_user = PostUser.find_by(uid: post_user.id)
        _post_user.name = post_user.name
        _post_user.profile_description = post_user.description
        _post_user.profile_image = post_user.profile_image_uri_https
        _post_user.save!
      end
    end
  end
end

PostUserBatch.execute