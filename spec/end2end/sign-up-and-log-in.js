describe('Sign Up and Log In', function() {
  beforeEach(function() {
    browser.get('http://localhost:3000');
  });

  it('logs in the user after successful sign up', function() {
    element(by.id('sign-up')).click();
    var signUpModal = element(by.id('sign-up-modal'));
    expect(signUpModal.isDisplayed()).toBe(true);

    element(by.model('user.first_name')).sendKeys('Test');
    element(by.model('user.last_name')).sendKeys('User');
    element(by.model('user.email')).sendKeys('testuser@shutter.com');
    element(by.model('user.password')).sendKeys('password123');
    element(by.model('user.password_confirmation')).sendKeys('password123');
    element(by.buttonText('Sign Up')).click();

    var sidebar = element(by.id('sidebar'));
    expect(sidebar.isDisplayed()).toBe(true);
  });

  it('logs in a user', function() {
  });
});
