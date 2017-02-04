# == Description
#
# Manage attendants.
#
# Only Admins can manage attendants.
class V1::AttendantsController < V1::ApplicationController

  # POST
  # Create a new attendant with random password and email their credentials.
  def create
    authorize! :create, Attendant
    email = params.dig :attendant, :email
    if email.blank?
      render_errors ["Email can't be blank"]
    end
    attendant = Attendant.new(attendant_params)
    attendant.password = SecureRandom.base58(6)
    if attendant.save
      send_welcome_email(email, attendant, current_user.username)
      head :created
    else
      render_errors attendant.errors.full_messages
    end
  end

  private

  # Extract params related to attendant.
  #
  # Do NOT require attributes here because
  # when they are missing this would raise
  #
  # +ActionController::ParameterMissing: param is missing or the value is empty+
  #
  # instead of returning proper validation
  # errors -- e.g. Title can't be blank.
  def attendant_params
    params[:attendant].permit(:username)
  end

  # Send an welcome email to the Attendant.
  # The email contains his username and password.
  def send_welcome_email(email, attendant, inviter_username)
    AttendantMailer
      .welcome(email, attendant.username, attendant.password, inviter_username)
      .deliver_now
  end

end
