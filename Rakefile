$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'RubyMotionParse'
  
  app.frameworks += [
         'AudioToolbox',
         'CFNetwork',
         'SystemConfiguration',
         'MobileCoreServices',
         'Security',
         'QuartzCore']

  app.vendor_project('vendor/Parse.framework', :static, 
    :products => ['Parse'], 
    :headers_dir => 'Headers')
end
