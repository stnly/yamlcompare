#!/usr/bin/ruby -w

require 'yaml'

unless ARGV.length >= 1
  $stderr.puts "Usage: #{$0} FILE1 [FILE2].."
  exit 1
end

def yaml_compare(yaml1, yaml2, arg)
  hash1 = Hash.new
  hash2 = Hash.new
  count = 0
  yaml1.each do |language, value|
    value.each do |key, data|
      hash1["#{key}"] = "#{data}"
    end
  end

  yaml2.each do |language, value|
    value.each do |key, data|
      hash2["#{key}"] = "#{data}"
    end
  end
  
  filename = arg.chomp(File.extname(arg))

  File.open("#{filename}.txt", "w") do |file|
     hash1.each do |key1, data1|
       found = 1
       hash2.each do |key2, data2|
         if "#{key1}" == "#{key2}"
           found = 0
         end
       end
       if found == 1
          file.puts "#{key1}: #{data1}"
          count += 1
       end
     end
  end
  puts "==> #{count} translations needed."
end

ARGV.each do |arg|
  yaml_compare(YAML.load_file("en.yml"), YAML.load_file("#{arg}"), arg)
end
