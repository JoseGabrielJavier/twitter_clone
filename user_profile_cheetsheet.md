<!-- create user profile page-->
1. IN user_controllers.rb 
-   def show
        @user = User.find(params[:id])
    end
<!-- the function above will tell our show page to find the information based on user id parameter-->

2. IN users_helper.rb
-   def gravatar_for(user, options = { size: 160 })
        size = options[:size]
        gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
        gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
        image_tag(gravatar_url, alt: user.name, class: "img-thumbnail")
    end
<!-- Add the function above, Gravatar is an image that represents you online, lets use gravatar for now in order for us to have a simple image representation -->

2. CREATE app/views/user/show.html.erb <!-- show is the file name of our view profile -->
-   <%= provide(:title, @user.name) %>
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <div class="row">
                        <div class="col-md-2">
                            <%= gravatar_for(@user) %>
                        </div>
                        <div class="col-md-6">
                            <h1><%= @user.name %></h1>
                            <h6><%= @user.email %></h6>
                        </div>
                        <div class="col-md-4">
                            <h5 class="d-inline p-3">Micropost</h5>
                            <h5 class="d-inline p-3">Following</h5>
                            <h5 class="d-inline p-3">Followers</h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
<!-- the block of code above will show our user information, as you noticed we called the "gravatar_for" function, this will display a avatar based on our email -->

4. IN _header.html.erb
-   <li><%= link_to "Profile", current_user, class: "dropdown-item" %></li>
<!-- replace the link profile into the line above, this will let us go to our profile as current_user -->

<!-- now test the project in browser -->