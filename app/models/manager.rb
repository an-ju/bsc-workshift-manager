class Manager < User

    def self.init(username, email, password)
        new_manager = Manager.new(username: username, password: password, email: email, manage: true)
        return new_manager.save
    end

end
