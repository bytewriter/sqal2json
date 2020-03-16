#!/bin/ruby
# I do not have permission to to install gems, therefore work-around missing mysql gem in their preferred language
require 'json'

results = []
headers = []
query=`mysql -B -u UserName -pPasswordHere -D DatabaseNameHere -e "SELECT * FROM tablename LIMIT 20;"|sed 's/\t/","/g;s/^/"/;s/$/"/'`

query.each_line do |line|
    line=line.chomp
    if not headers.any?
        headers = line.split(",")
        next
    end
    question=line.split(",")
    hash=headers.zip(question).to_h
    results.push(hash)
end
puts results.to_json.gsub('\\"','')
