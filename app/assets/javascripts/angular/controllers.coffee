//= require ./controllers/base
//= require_tree ./controllers

for name, klass of Shutter.Controller
  new klass if name isnt 'Base'
