class Main
  files  = Dir[root(%w[app views js jquery.js])]
  files  = Dir[root(%w[app views js jquery.*.*])]
  files += Dir[root(%w[app views js underscore.js])]
  files += Dir[root(%w[app views js backbone.js])]
  files += Dir[root(%w[app views js lib.*.*])]
  files += Dir[root(%w[app views js setup.*])]
  files += Dir[root(%w[app views js app.*.*])]
  set :js_files, JsFiles.new(files, :prefix => '/js/')
end
