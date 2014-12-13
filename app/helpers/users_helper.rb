require "net/http"
module UsersHelper
  def profile_image(user)
    uri = URI.parse("http://res.cloudinary.com/sample-blog/image/upload/#{@user.image_id}")
    request = Net::HTTP.new uri.host
    response = request.request_head uri.path
    if response.code.to_i == 200
      cl_image_tag(uri, width: 120, height: 120)
    else
      image_tag("no_photo.gif", width: 120, height: 120)
    end
  end
end
