<!-- updating users cheetsheet -->

1. IN users_controller.rb 
-   def edit
        @user = User.find(params[:id])
    end
<!-- this will able us to access the edit page -->

2. CREATE app/views/users/edit.html.erb
-   <%= provide(:title, "Edit Profile") %>
    <% provide(:button_text, "Edit") %>
    <div class="row">
        <div class="col-md-3"></div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h2 class="text-center">Sign Up</h2>
                </div>
                <div class="card-body">
                    <%= render "form" %>
                </div>
            </div>
        </div>
        <div class="col-md-3"></div>
    </div>
<!-- above is the code for edit page, as you noticed it also uses the "render form" from sign up, sign up and edit are basically have the same forms so we just recycled it -->

3. IN users_controller.rb
-   def update
        @user = User.find(params[:id])
            if @user.update(user_params)
            redirect_to root_url, flash: "Profile updated"
        else
            render "edit"
        end
    end
<!-- add the code above below edit function, update is the action that will be called if we press the button "save" -->

4. IN application_controller.rb
-   def logged_in_user
        redirect_to login_url, alert: "Please login first" unless logged_in? 
    end
<!-- the above code is an authorization function, this will determine if a user is login or not if if not it will bring you to the home page again -->

5. IN users_controller.rb
-   before_action :logged_in_user, except: [:new, :create]
<!-- add this line and paste it in line 2, from the word before_action, it will call the function "logged_in_user" we created in application_controller. basically it check if the user is logged in or not first before you can edit your profile -->

6. IN users_controller.rb
-   before_action :correct_user, only: :edit
<!-- add this after "before_action :logged_in_user, except: [:new, :create]", same as the line above. this will call correct_user function first. -->

7. IN users_controller.rb
-   def correct_user
        user = User.find(params[:id])
            if user != current_user
            redirect_to root_url, alert: "You are not authorized."
        end
    end
<!-- add this block of code under "private", this function is to avoid editing other profile and must be only yours (you don't want other people to edit your profile)-->