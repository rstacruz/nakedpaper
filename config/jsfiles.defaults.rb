class Main
  # Libraries
  files  = Dir[root(%w[app views js vendor jquery.js])]
  files  = Dir[root(%w[app views js vendor jquery.*.*])]
  files += Dir[root(%w[app views js vendor underscore.js])]
  files += Dir[root(%w[app views js vendor backbone.js])]

  files += Dir[root(%w[app views js lib *.*])]

  # Backbone
  files += Dir[root(%w[app views js models *.*])]
  files += Dir[root(%w[app views js views *.*])]
  files += Dir[root(%w[app views js controllers *.*])]

  # Behaviors
  files += Dir[root(%w[app views js app.*.*])]

  set :js_files, JsFiles.new(
    files,
    :prefix => '/js',
    :file_prefix => root(%w[app views js]))
end
