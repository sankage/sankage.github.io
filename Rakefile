ssh_user   = ''
local_user = ''

def jekyll(opts="", path="")
  sh "rm -rf _site"
  sh path + "jekyll " + opts
end

desc "Build site using Jekyll"
task :build do
  jekyll
end

desc "Serve on Localhost with port 4000"
task :preview do
  jekyll "--server 4321 --auto"
end

desc "Deploy to Dev"
task :deploy => :"deploy:local"

namespace :deploy do
  desc "Deploy to Local"
  task :local => :build do
    rsync local_user, "infosurv.com"
  end

  desc "Deploy to Dev"
  task :dev => :build do
    rsync ssh_user, "dev.infosurv.com"
  end
  
  desc "Deploy to Live"
  task :live => :build do
    rsync ssh_user, "infosurv.com"
  end
  
  desc "Deploy to Dev and Live"
  task :all => [:dev, :live, :local]
  
  def rsync(user, domain)
    sh "rsync -rtz --delete _site/ #{user}:~/#{domain}/"
  end
end

namespace :post do
  desc "Create a new post"
  task :new, :title do |t, args|
    args.with_defaults(:title => 'new-post')
    title = args.title
    filename = "_posts/#{Time.now.strftime('%Y-%m-%d')}-#{url_from(title)}.md"
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
