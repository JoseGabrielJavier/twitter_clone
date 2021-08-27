module UsersHelper
  def gravatar_for(user, options = { size: 160 }) # gravatar is an online avatar provider
    size = options[:size]
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "img-thumbnail")
  end
end
