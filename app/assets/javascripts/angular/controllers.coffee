//= require ./controllers/base
//= require_tree ./controllers

for klass, controller of Shutter.Controller
  if klass != 'Base'
    new controller()
