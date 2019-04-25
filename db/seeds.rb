# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"

csv_text = File.read(Rails.root.join("db", "media_seeds.csv"))
csv = CSV.parse(csv_text, :headers => true, :encoding => "ISO-8859-1")
csv.each do |row|
  t = Work.new
  t.category = row["category"]
  t.title = row["title"]
  t.creator = row["creator"]
  t.publication_year = row["publication_year"]
  t.description = row["description"]
  t.save
  puts "#{t.title} saved"
end
