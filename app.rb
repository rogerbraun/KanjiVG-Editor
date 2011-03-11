require "./lib/simplegit.rb"
require "./config.rb"
require "./initialize.rb"
require "./svg_files.rb"
require "sinatra"
require "erb"
require "cgi"

set :svg_files, SVG_files.new(GIT_DIR)
set :repo, @repo

get "/" do
  @all_codes = settings.svg_files.keys
  erb :index
end

get "/svg/:char" do
  redirect "/svg/#{CGI.escape(params[:char])}/0"
end

get "/svg/:char/:version" do
  if settings.svg_files.exists?(params[:char]) then 
    @svg_code = settings.svg_files.get_code(params[:char], params[:version].to_i)
    @svg_raw= settings.svg_files.get_raw(params[:char], params[:version].to_i)
    @filename = settings.svg_files.get_filename(params[:char], params[:version].to_i)
    @versions = settings.svg_files.versions(params[:char])
  end
  erb :svg
end

post "/svg/:char/:version" do
  if settings.svg_files.exists?(params[:char]) then 

    @filename = settings.svg_files.get_filename(params[:char], params[:version].to_i)

    open(@filename,"w") do |f|
      f.write(params[:code])
    end
    msg = params[:message].empty? ? "Changed #{params[:char]}" : params[:message]
    settings.repo.commit_all(msg)
  end 
  redirect back
end    
