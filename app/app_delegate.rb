class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    Parse.setApplicationId(ENV["RUBYMOTION_PARSE_APP_ID"], clientKey:ENV["RUBYMOTION_PARSE_CLIENT_KEY"])
    avoid_evil_error
    self.presentMainViewController
    true
  end
  
  def avoid_evil_error
    # For some reason without this code, you get stuck with:
    # Objective-C stub for message `setApplicationId:clientKey:' type `v@:@@' not precompiled. Make sure you properly link with the framework or library that defines this message.
    testObject = PFObject.objectWithClassName("TestObject")
    testObject.setObject("BoilerPlate", forKey:"foo")
  end

  def presentMainViewController
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = MainController.alloc.init    
    @window.rootViewController.wantsFullScreenLayout = true
    @window.makeKeyAndVisible
  end
end