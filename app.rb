require "./lib/simplegit.rb"
require "./config.rb"
require "./initialize.rb"
require "./svg_files.rb"
require "sinatra"
require "erb"
require "cgi"

set :kanjis, Kanji.load_kanjis(GIT_DIR)
set :repo, @repo

get "/" do
  @all_codes = settings.kanjis.keys
  erb :index
end

get "/svg/:char" do
  redirect "/svg/#{CGI.escape(params[:char])}/0"
end

get "/svg/:char/:version" do
  if settings.kanjis[params[:char]] then 
    @kanji = settings.kanjis[params[:char]]
  end
  erb :svg
end

post "/svg/:char/:version" do
  if settings.kanjis[params[:char]] then 

    @filename = settings.kanjis[params[:char]].name(params[:version].to_i)

    open(@filename,"w") do |f|
      f.write(params[:code])
    end
    msg = params[:message].empty? ? "Changed #{params[:char]}" : params[:message]
    settings.repo.commit_all(msg)
  end 
  redirect back
end    
