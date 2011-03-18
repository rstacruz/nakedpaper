class Main
  files  = Dir[root(%w[public js jquery.*.js])]
  files += Dir[root(%w[public js underscore.js])]
  files += Dir[root(%w[public js backbone.js])]
  files += Dir[root(%w[public js lib.*.js])]
  files += Dir[root(%w[public js app.js])]
  files += Dir[root(%w[public js app.*.js])]
  set :js_files, JsFiles.new(files, :prefix => '/js/')
end
