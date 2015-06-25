namespace :db do
  desc "Reset db"
  task reset: :environment do
    %w(drop create migrate seed).each do |t|
      Rake::Task["db:#{t}"].invoke
    end
  end

end
