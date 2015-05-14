# Angular & Rails on Heroku Base Project
----
#### This is a Rails & AngularJS app that is ready to be deployed on Heroku. 
You can immediately start using AngularJS and Rails, and deploy to Heroku without any configuration.

You can see the deployed project here: http://angular-rails-heroku-base-proj.herokuapp.com/.

This is the most unopinionated and barebones base project for Rails & AngularJS I could make.

#### Why?
Configuring AngularJS to work with the Rails asset pipeline is annoying. Configuring all of it to work with Heroku is also annoying. This saves me (and hopefully you) the configuration annoyance for future Angular & Rails projects.

#### What comes with the project?
Nothing. It's a base project. It has AngularJS and Bootstrap UI. You can remove Bootstrap UI by deleting one line of code in application.css. Oh, it also has this splash page.

#### How is the base project organized?
**Rails app** is organized in the exact same way as if you just do `rails new` in your console.

**AngularJS app** is all inside of `/app/assets/javascripts`. I use `/app/assets/javascript/app.js` for the main app, but you don't have to. I also made a folder for my angular templates in `/app/assets/javascripts/`, but you can include any angular stuff from anywhere inside of `/app/assets/javascripts` into your application.js like any other javascript file. 

#### Adding new gems
Use the `gemfile` like normal.

#### Adding JS libraries
This uses **Bower** for Rails. Lot of advantages over trying to use gems for JS libraries, but for brevity I won't go into them here. Basically JS libraries are better versioned in Bower, and you can include almost anything you want.

1. Open `/Bowerfile`. Add a line for the JS library to include, for example `asset 'bootstrap'`.
2. Open your console in your project's root directory. Run `rake Bower:install` to download the JS assets. Assets will be downloaded to `/vendor/assets/bower_components/`.
3. Open your `application.js` file. Add a line including your new JS component. I've included the Angular components there so you can see examples of how this is done.

### ~*# The End #*~
