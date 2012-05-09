class MainController < UIViewController

  def viewDidAppear(animated)
    super
    if PFUser.currentUser
      showTimer
    else
      login = PFLogInViewController.alloc.init
      login.delegate = self
      login.signUpController.delegate = self
      self.presentModalViewController(login, animated:true)
    end
  end

  def logInViewController(logInController, didLogInUser:user)
    self.dismissModalViewControllerAnimated(true)
  end

  def logInViewControllerDidCancelLogIn(logInController)
    self.dismissModalViewControllerAnimated(true)
  end

  def signUpViewController(signUpController, didSignUpUser:user)
    self.dismissModalViewControllerAnimated(true)
  end

  def signUpViewControllerDidCancelLogIn(signUpController, didLogInUser:user)
    self.dismissModalViewControllerAnimated(true)
  end

  def showTimer
    margin = 20

    @state = UILabel.new
    @state.font = UIFont.systemFontOfSize(30)
    @state.text = 'Tap to start'
    @state.textAlignment = UITextAlignmentCenter
    @state.textColor = UIColor.whiteColor
    @state.backgroundColor = UIColor.clearColor
    @state.frame = [[margin, 200], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@state)

    @action = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @action.setTitle('Start', forState:UIControlStateNormal)
    @action.setTitle('Stop', forState:UIControlStateSelected)
    @action.addTarget(self, action:'actionTapped', forControlEvents:UIControlEventTouchUpInside)
    @action.frame = [[margin, 260], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@action)

    @logout_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @logout_button.setTitle('Logout', forState:UIControlStateNormal)
    @logout_button.addTarget(self, action:'logoutTapped', forControlEvents:UIControlEventTouchUpInside)
    @logout_button.frame = [[margin, 320], [view.frame.size.width - margin * 2, 40]]
    view.addSubview(@logout_button)
  end

  def logoutTapped
    PFUser.logOut
    appDelegate = UIApplication.sharedApplication.delegate
    appDelegate.presentMainViewController
  end

  def actionTapped
    if @timer
      @timer.invalidate
      @timer = nil
    else
      @duration = 0
      @timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector:'timerFired', userInfo:nil, repeats:true)
    end
    @action.selected = !@action.selected?
  end

  def timerFired
    @state.text = "%.1f" % (@duration += 0.1)
  end
  
end