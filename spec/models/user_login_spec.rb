require 'spec_helper'
require 'rails_helper'

# These tests were more important when login was implemented from scratch
# Now that the login is handled by devise, these tests mostly show that
# we've implemented devise somewhat properly, and know what to expect from it

describe User do

    before(:each) do
        @user  = "Bob"
        @email = "Bob@berkeley.edu"
        @pass  = "abc123"
        @building = "Soda"
    end  # otherwise, User.save will fail validation test, in "properly saves" part.

    it "accepts a username, email, password, and building" do
        expect(User).to receive(:new).and_return(User.new(username: @user, password: @pass, email: @email))
        User.init(@user, @email, @pass, @building)
    end

    it "correctly hides the password" do
        User.init(@user, @email, @pass, @building)
        expect(User.find_by(username: @user).encrypted_password).not_to eq(@pass)
    end

    it "properly saves" do
        v = User.init(@user, @email, @pass, @building)
        expect(v).to eq(true)
    end

end
