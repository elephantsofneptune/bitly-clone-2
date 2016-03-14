#read
get '/' do
  @urls = Url.last(5).reverse

  erb :'/index'
  # Allow user to create short URLs.
  # Display a list of shortened URLs.
end

#create
post '/urls' do

  @url = Url.new(long: params[:long])
  if !!Url.find_by(long: @url.long)
    existing = Url.find_by(long: @url.long)
    # ajax request to append the existing url to the homepage
    flash[:error] = "This URL has been shortened already: #{existing.shortened}"
    redirect '/'
  end
  @url.save
  if @url.save
    erb :'/_show', locals: {url: @url}, layout: false
  else
    flash[:error] = "Please enter a valid URL beginning with 'http://' or 'https://'"
    redirect '/'
  end
end

#new
# e.g., /c3por2d2
get '/:short_url' do
  # Redirect to appropriate "long" URL.
  url = Url.find_by(shortened: params[:short_url])
  url.share_count += 1
  url.save
  redirect "#{url.long}"

end
