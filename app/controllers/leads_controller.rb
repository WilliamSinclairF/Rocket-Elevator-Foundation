class LeadsController < ApplicationController
  include ZendeskHelper

  def user_leads
    @leads = Lead.where(user_id: current_user.id)
  end

  def create
    @lead = Lead.new(lead_params)
    @lead.user_id = current_user.id if user_signed_in?
    @lead.save
      respond_to do |format|
        if @lead.save && user_signed_in?
          format.html do
            redirect_to my_leads_path,
                        notice:
                          'Your contact request has been sent successfully.'
          end
          create_zd_ticket(@lead, 'question')
        elsif @lead.save && !user_signed_in?
          format.html do
            redirect_to root_path,
                        notice:
                          'Your contact request has been sent successfully.'
          end
          create_zd_ticket(@lead, 'question')
        else
          render :new
        end
      end
  end

  def new
    @lead = Lead.new
  end

  private

  def lead_params
    params.require(:lead).permit(
      :attachment,
      :full_name,
      :email,
      :phone,
      :business_name,
      :project_name,
      :department,
      :project_description,
      :message,
      :user_id
    )
  end
end
