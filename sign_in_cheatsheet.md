Cheatsheet for sign in and sign out

<!-- CREATING CONTROLLER -->
1. IN terminal
-   docker-compose run web rails generate controller Sessions new create destroy
<!-- generates a controller called Session, that has actions new, create, destroy -->
<!-- Additional notes
        - We are NOT creating a new user
        - The create method for Sessions will have the responsibility of finding the user based on the [user_params] (or user information entered)
        - Sessions DOES NOT need to be saved in the database because it’s a temporary action
        - We have Sessions so that we AVOID having multiple users logged in (in the same machine) -->

2. IN routes.rb
<!-- remove the lines below -->
-   get 'sessions/new'
    get 'sessions/create'
    get 'sessions/destroy'

<!-- Add this code instead, this will allow us to use the sessions controller -->
-   get "/login", to: "sessions#new"
    delete "/logout", to: "sessions#destroy"
    resources :sessions, only: :create

<!-- CREATING LOGIN PAGE -->
1. IN _header.html.erb
-   <li class="nav-item">
        <%= link_to "Login", login_path, class: "nav-link" %>
    </li>
<!-- add this in our navbar, so that we can now click sign in -->

2. IN app/view/sessions/new.html.erb
-   <%= provide(:title, "Login") %>
    <% provide(:button_text, "Login") %>
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h2 class="text-center">Login</h2>
                </div>
                <div class="card-body">
                    <%= render "form" %> 
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
<!-- paste this code above, this code is the container for our partial login form -->

3. CREATE a partial in app/view/sessions/_form.html.erb <!-- this will create a partial form inside session folder, this means only the session can access this form -->
-   <%= form_with(url: sessions_path, scope: :session, local: true) do |f| %>
        <%= render 'shared/error_messages', object: f.object %>
        <form>
            <div class="mb-3">
                <%= f.label :email, class: "form-label"%>
                <%= f.email_field :email, class: "form-control", placeholder: "Email" %>
            </div>
            <div class="mb-3">
                <%= f.label :password, class: "form-label"%>
                <%= f.password_field :password, class: "form-control", placeholder: "Password" %>
            </div>
            <div class="d-grid gap-2">
                <%= f.submit yield(:button_text), class: "btn btn-primary" %>
            </div>
        </form>
    <% end %>
<!-- the code above is the form for login, as you see. There are only 2 fields which accepts email and password -->

<!-- CREATING USER AUTHENTICATION -->
1. IN sessions_controller.rb
-   def create
        user = User.find_by(email: params[:session][:email].downcase)
        if user && user.authenticate(params[:session][:password])
            log_in(user)
            flash[:success] = "Successfully logged in."
            redirect_to root_path
        else
            flash[:danger] = "Invalid credentials"
            render :new
        end
    end
<!-- add the code above, this will authenticate whether our the user credentials are valid or not -->

2. IN sessions_helper.rb
-   def log_in(user)
        session[:user_id] = user.id
    end
<!-- add the code above, this register the current user in our browser temporily -->

3. IN application_controller
-   include SessionsHelper
<!-- add the line above in order to tell our application that we are currently using session_helper.rb -->

4. IN sessions_helper.rb
-   def current_user
        User.find_by(id: session[:user_id])
    end
<!-- the code above will be useful when we are trying to find something in the database using the current_user, as you can see we are refering to session[:user_id] -->

<!-- ADDING MORE FUNCTIONS IN SESSION HELPER -->
1. IN session_helper.rb
-   def logged_in?
        !current_user.nil?
    end
<!-- add the code above, this will determine if our user is currently login or not -->

2. IN session_helper.rb
-   def log_out
        session.delete(:user_id)    
    end
<!-- this function will be called if we log_out our account-->

3. IN session_controller.rb
-   def destroy
        Log_out
            flash[:success] = "Successfully logout."
        redirect_to root_url
    end
<!-- add this in order for us to logout -->

<!-- CHANGE THE LAYOUT LINK small activity add dropdown --> 
1. IN _header.html.erb
-   <% if logged_in? %>
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                Account
            </a>
            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                <li><%= link_to "Profile", "", class: "dropdown-item" %></li>
                <li><%= link_to "Settings", "", class: "dropdown-item" %></li>
                <li><hr class="dropdown-divider"></li>
                <li><%= link_to "Log out", logout_path, method: :delete, class: "dropdown-item" %></li>
            </ul>
        </li>
    <% else %>
        <li class="nav-item">
            <%= link_to "Sign Up", signup_path, class: "nav-link" %>
        </li>
        <li class="nav-item">
            <%= link_to "Login", login_path, class: "nav-link" %>
        </li>
    <% end %>