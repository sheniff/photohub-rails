Things to keep in mind when setting up the app
==============================================

* Create it without default test suit (we'll use rspec)
```
rails new app_name --skip-test-unit
bundle --without production
```

* Use Gemfile from
```
bit.ly/rails_tutorial_gemfile
```

* Configure rspec
```
rails g rspec:install
```

* Use Git as CVS
```
git init
```

* deploy on heroku and open our project with them
```
heroku create --stack cedar
heroku open
```

* Generate controllers WITHOUT test files and tests with rspec
```
rails g controller myCont --no-test-framework
rails g integration_test myCont
```

Using TDD with rspec and spork
==============================

* Edit .rspec to use spork (configure it previously as said in http://youtu.be/FZ-b9oZpCZY)
```
--drb
```

* Move generated code in spec_helper.rb INTO Spork.prefork 

* Launch it
```
spork
```
