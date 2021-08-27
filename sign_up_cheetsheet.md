Cheetsheet for user sign up

<!-- creating Users controller and User model -->
1. IN terminal
docker-compose exec web rails generate controller Users new <!-- this will create users controller with a "new/method" action inside-->
2. IN routes.rb
resources :users  <!-- add this line, this will able our project to access user path such like "new" action -->
get "/signup", to: "user#new"  <!-- this will convert "localhost:3002/users/new" into "localhost:3002/signup" for easy access -->
3. IN terminal
docker-compose exec web rails generate model User name:string email:string password_digest:string <!-- creates User model with name, email, password_digest in order for our users to sign up-->
docker-compose exec web rails db:migrate <!-- will apply the model created above in our database -->

<!-- setting up user validations -->
1. IN user.rb <!-- this block of code below will validate the user's input like invalid email format or password length -->
validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
validates :email, presence: true, length: { maximum: 255 },
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: true
has_secure_password
validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
2. IN gemfile <!-- uncomment this line below in gemfile (quick note: "gems" are piece of codes that other developers created that's ready to use for us) -->
gem 'bcrypt', '~> 3.1.7' <!-- uncomment this, this gem will enable us to encrypt out password (prevets to be hacked) -->
3. IN terminal
docker-compose down <!-- we need to rebuild our project in order for the gems, stop it first -->
docker-compose up --build -d <!-- this will rebuild our project in order for our gems to install -->

<!-- updating the layout -->
1. IN _header.html.erb
<li class="nav-item">
   <%= link_to "Signup", signup_path, class: "nav-link" %>
</li> <!-- add this on navbar -->

2. IN users_controller.rb
def new
    @user = User.new
end <!-- assign @user to controller, this will also prevent us from getting errors in error_messages and flash_messages below -->

3. CREATE app/views/shared/_error_messages.html.erb
<% if object.errors.any? %>
    <div class="alert alert-danger" role="alert">
        <% object.errors.full_messages.each do |msg| %>
            <li><%= msg %></li>
        <% end %>
    </div>
<% end %>
<!-- the block of code above will allow our program to display "errors" when we are signing up -->

4. CREATE app/views/shared/_flash_messages.html.erb
<% flash.each do |type, message| %>
    <div class="alert alert-warning" role="alert">
        <%= message %>
    </div>
<% end %>
<!-- the block of code above will allow our program to inform us "successful" messages like "congrationlations" -->


5. CREATE app/views/users/_form.html.erb
<%= form_with(model: @user, local: true) do |f| %>
    <%= render 'shared/error_messages', object: f.object %> <!-- this will render error partial -->
    <form>
        <div class="mb-3">
            <%= f.label :name, class: "form-label"%>
            <%= f.text_field :name, class: "form-control", placeholder: "Name" %>
        </div>
        <div class="mb-3">
            <%= f.label :email, class: "form-label"%>
            <%= f.email_field :email, class: "form-control", placeholder: "Email" %>
        </div>
        <div class="mb-3">
            <%= f.label :password, class: "form-label"%>
            <%= f.password_field :password, class: "form-control", placeholder: "Password" %>
        </div>
        <div class="mb-3">
            <%= f.label :confirm_password, class: "form-label"%>
            <%= f.password_field :confirm_password, class: "form-control", placeholder: "Confirm Password" %>
        </div>
        <div class="d-grid gap-2">
            <%= f.submit yield(:button_text), class: "btn btn-primary" %>
        </div>
    </form>
<% end %>
<!-- the block of code above will create form that will displayed in our browser, this is where our users enter their information and sign up -->

5. ADD this inside users_controller.erb
def create
    @user = User.new(user_params)
    if @user.save
        flash[:success] = "Successfully Created a Account."
        redirect_to root_url
    else
        render "new"
    end
end

private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

<!-- the block of code above is the actions neeeded for our form to work, if the user enters information and click submit the "create" action above will be called. If there are no errors then the user will be saved but if there are then the page will reload and displays errors -->

6. IN new.html.erb
<%= render "form" %> <!-- this will render "form" partial inside new/signup page -->

7. application.html.erb
<div class="my-3">
    <%= render "shared/flash_messages" %> <!-- this will render flash messages partial -->
</div>

<!-- try the code -->