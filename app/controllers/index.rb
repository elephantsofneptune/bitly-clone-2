#read
get '/' do
  @urls = Url.last(5).reverse

  erb :'/index'
  # Allow user to create short URLs.
  # Display a list of shortened URLs.
end

#create
post '/urls' do
  @error = nil
  @url = Url.find_or_initialize_by(long: params[:long])
  @url.save
  if @url.valid?
    erb :'/_show', locals: {url: @url}, layout: false
  else
    @error = "Please enter a valid URL beginning with 'http://' or 'https://'"
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
