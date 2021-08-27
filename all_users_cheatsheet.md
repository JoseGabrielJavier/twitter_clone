<!-- showing all registered users -->

1. CREATE a new file app/view/users/index.html.erb <!-- we will be showing all the users registered in this page -->

2. IN users_controller.rb add this line blow
def index # this will select all users from user table
    @users = User.all
end
<!-- the code above will fetch all users from the database, if you notice its using the keyword .all (means all users) -->

3. IN app/view/users/index.html.erb
<%= provide(:title, "All Users") %>
<div class="row">
    <div class="col-md-12">
        <% @users.each do |user| %>
            <div class="row">
                <div class="col-md-2">
                </div>
                <div class="col-md-8">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-2">
                                    <%= gravatar_for(user) %>
                                </div>
                                <div class="col-md-10">
                                    <h1><%= user.name %></h1>
                                    <h6><%= user.email %></h6>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-2">
                </div>
            </div>
        <% end %>
    </div>
</div>
<!-- add the block of code above, this will show all the users that are registered in the database, as you noticed there is a keyword .each which means each users will display its details -->

4. IN _header.html.erb 
<li class="nav-item">
    <%= link_to "All Users", users_path, class: "nav-link" %>
</li>
<!-- now add the code above after <% if logged_in? %> to allow us to go to users page -->