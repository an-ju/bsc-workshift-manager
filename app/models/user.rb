require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :preferences #, :dependencies => :destroy
    @@cipher = OpenSSL::Cipher::AES.new(256, :CFB) #Will implement encryption for sensitive data

    def self.init(username, password)
        User.create!(username: username, password: password, email: username + "@berkeley.edu")
    end

    def self.validate(username, password)
        hashed_pass = Digest::SHA256.hexdigest password
        user = User.find_by(username: username)

        if user == nil || user.hashed_pass != hashed_pass
            return false
        end

        return true
    end
end
