require 'rake'

namespace :add_dates do

  desc "TODO"
  task my_task1: :environment do
  	Post.all.each do |post| 
  		post.image.recreate_versions!
  end

end
