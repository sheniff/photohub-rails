Things to keep in mind when setting up the app
==============================================

* Create it without default test suit (we'll use rspec)
```
rails new app_name --skip-test-unit
bundle --without production
```

* Use Gemfile from http://bit.ly/rails_tutorial_gemfile

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
git push heroku
heroku open
```

* Generate controllers WITHOUT test files
```
rails g controller myCont --no-test-framework
```

Using TDD with rspec and spork
==============================
* Generate tests with rspec for a controller
```
rails g integration_test myCont
```

* Edit .rspec to use spork (configure it previously as said in http://youtu.be/FZ-b9oZpCZY)
```
--drb
```

* Move generated code in **spec_helper.rb** INTO **Spork.prefork**

* Launch it
```
spork --bootstrap
spork
```
