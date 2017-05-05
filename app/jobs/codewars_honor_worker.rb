class CodewarsHonorWorker
  include Sidekiq::Worker
  sidekiq_options queue: :codewars_api

  def perform(user_id)
    return unless user_id
    puts "JOB FOR #{user_id}"
    user = User.find(user_id)

    UpdateUserCodewarsHonor.call(user: user)
  end
end
