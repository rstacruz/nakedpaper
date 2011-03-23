class Main
  # Libraries
  files  = Dir[root(%w[app js vendor jquery.js])]
  files  = Dir[root(%w[app js vendor jquery.*.*])]
  files += Dir[root(%w[app js vendor underscore.js])]
  files += Dir[root(%w[app js vendor backbone.js])]

  files += Dir[root(%w[app js lib *.*])]

  # Backbone
  files += Dir[root(%w[app js models *.*])]
  files += Dir[root(%w[app js views *.*])]
  files += Dir[root(%w[app js controllers *.*])]

  # Behaviors
  files += Dir[root(%w[app js app.*.*])]

  set :js_files_list, files
end
