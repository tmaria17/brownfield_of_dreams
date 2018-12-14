namespace :video_position do
  des "changes postion on videos that have nil positions"
  task :position_assignment :environment do
    Video.where(position: nil).map do |video|
      video.update_attributes(position: Tutorial.find(video.tutorial_id).videos.maximum(:position)+1)
    end
    puts "Videos have been updated."
  end
end
