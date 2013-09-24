require 'active_record/fixtures'

namespace :random do

  CATEGORIES = %w[realstate employment stock computer finance]

  def generate_random_string
    alph =  [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    (0...50).map{ alph[rand(alph.length)] }.join
  end

  desc "Load development user fixtures"
  task :user => [:environment, "db:migrate"] do
    puts "Loading user fixtures ..."
    ActiveRecord::FixtureSet.create_fixtures(Rails.root.join('test', 'fixtures'), 'users')
  end

  desc "Create categories"
  task :category => :environment do
    "Creating categories . . ."
    CATEGORIES.each do |name|
      Category.create(:name => name, :cssclass => name)
    end
  end

  desc "Create random advertises in database"
  task :advertise => :environment do
    puts "Create random advertises . . ."
    user_count = User.count

    1.upto(1000) do |i|
      puts "Create \##{i}"
      Advertise.create!(:title => generate_random_string,
                       :user_id => 1 + rand(user_count),
                       :category_id => 1 + rand(CATEGORIES.length),
                       :size => 1 + rand(Advertise::SIZES.length),
                       :show_for_days => rand(30),
                       :cost => rand(500000))

    end

  end

  desc "Fill db with random data"
  task :data => [:user, :category, :advertise]
end
