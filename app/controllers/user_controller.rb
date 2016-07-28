class UserController < ApplicationController
  def create
    @user = User.new({email: "newemail@email.com"})
    @user.save
  end
end
