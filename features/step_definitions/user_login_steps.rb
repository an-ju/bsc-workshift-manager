Given /^user "(.*)" exists with password "(.*)"/ do |us, pa|
    User.init(us, us + "@berkeley.edu", pa + "123456")
end

When /^(?:|I )log in as "(.*)" with password "(.*)"$/ do |us, pa|
    email = us + "@berkeley.edu"
    pass = pa + "123456"

    steps %Q{
        select "#{email}" from "user_email"
        fill in "user_password" with "#{pass}"
        press "commit"
    }
end

When /^(?:|I )am not logged in$/ do
    page.driver.submit :delete, "/users/sign_out", {}
end
