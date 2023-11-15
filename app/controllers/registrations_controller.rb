# app/controllers/registrations_controller.rb

class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      puts "Resource: #{resource.inspect}"
      puts "Errors: #{resource.errors.full_messages.inspect}" if resource.errors.any?
    end
  end
end
