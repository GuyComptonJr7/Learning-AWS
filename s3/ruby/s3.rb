require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

bucket_name = ENV['BUCKET_NAME']
region='us-east-1'

client = Aws::S3::Client.new()

client.create_bucket(
    bucket: bucket_name
)

number_of_files = 1 + rand(6)
puts "number_of_files: #{number_of_files}"

number_of_files.times.each do |i|
    puts "i: #{i}"
    filename = "file_#{i}.txt"
    output_path = "/tmp/#{filename}"

    File.open(output_path, "w") do |f|
        f.write(SecureRandom.uuid)
    end
    
    File.open(output_path, "rb") do |f|
        client.put_object(
            bucket: bucket_name,
            key: filename,
            body: f
        )
    end
end