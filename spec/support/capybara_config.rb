RSpec.configure do |config|
  config.before(:each, type: :feature) do
    Capybara.default_driver = :selenium
    Capybara.page.driver.browser.manage.window.maximize()
    OmniAuth.config.test_mode = true
    Capybara.default_wait_time = 10
  end

  config.before(:each) do
    seed
  end
end
