/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

document.addEventListener("turbolinks:load", function() {
  console.log('Hello World from Webpacker')
})

// Add Stimulus for Javascript sprinkles
// import { Application } from "stimulus"
// import { autoload } from "stimulus/webpack-helpers"

// const application = Application.start()
// const controllers = require.context("./controllers", true, /\.js$/)
// autoload(controllers, application)
