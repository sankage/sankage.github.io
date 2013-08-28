require 'fileutils'

def jekyll(opts="", path="")
  sh "rm -rf _site"
  sh path + "jekyll " + opts
end

desc "Build site using Jekyll"
task :build do
  jekyll "build"
end

desc "Serve on Localhost with port 4000"
task :preview do
  jekyll "serve --watch"
end

namespace :post do
  desc "Create a new post"
  task :new do |t|
    title = get_stdin("What is the title of the post? ")
    filename = "_drafts/#{url_from(title)}.md"
    if File.exist?(filename)
      abort("rake aborted!") if ask("#{filename} already exists. Do you want to overwrite?", ['y', 'n']) == 'n'
    end
    puts "Creating new post: #{filename}"
    open(filename, 'w') do |post|
      post.puts "---"
      post.puts "layout: post"
      post.puts "title: #{title.gsub(/&/,'&amp;')}"
      post.puts "date: #{Time.now.strftime('%Y-%m-%d %H:%M')}"
      post.puts "category: "
      post.puts "---"
    end
  end

  desc "Publish a draft"
  task :publish do |t|
    files = Dir.glob('_drafts/*')
    files.each_with_index do |file, index|
      puts "#{index} - #{file}"
    end
    unless files.empty?
      file_num = get_stdin("Which draft (0-#{files.length - 1})? ").to_i
      filename = File.basename(files[file_num])
      FileUtils.mv files[file_num], "_posts/#{Time.now.strftime('%Y-%m-%d')}-#{filename}"
    end
  end
end

desc "Copy compiled stylesheet to raw folder for Github"
task :publish => ["build"] do
  FileUtils.cp("_site/css/styles.css", "css")
end

def ask(message, valid_options)
  if valid_options
    answer = get_stdin("#{message} #{valid_options.to_s.gsub(/"/, '').gsub(/, /,'/')} ") while !valid_options.include?(answer)
  else
    answer = get_stdin(message)
  end
  answer
end

def get_stdin(message)
  print message
  STDIN.gets.chomp
end

def url_from(value)
  value.gsub(/&/, "and").downcase.gsub(/\s+/, "-").sub(/^#{"-"}*/, "").sub(/#{"-"}*$/, "").squeeze("-")
end
