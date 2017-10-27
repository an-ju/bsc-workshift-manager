require 'digest'
require 'openssl'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable

    has_many :preferences #, :dependencies => :destroy
    @@cipher = OpenSSL::Cipher::AES.new(256, :CFB) #Will implement encryption for sensitive data

    def self.init(username, email, password)
        return User.create(username: username, password: password, email: email)
    end

end
