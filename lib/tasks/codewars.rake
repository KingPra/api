namespace :codewars do
  desc "Iterate over every user in DB and update codewars honor via API"
  task update_honor: :environment do
    User.pluck(:id).each do |user_id|
      puts "Queuing update for User with id: #{user_id} @ #{Time.zone.now}"
      CodewarsHonorWorker.perform_in(15.seconds, user_id)
    end
  end
end
