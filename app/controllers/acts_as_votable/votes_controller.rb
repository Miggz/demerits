class ActsAsVotable::VotesController < ApplicationController
  load_polymorphic_from_url :votable
  
  # GET /votable/:votable_id/vote
  def show
    respond_to do |format|
      format.html do
        target_url = url_for(@votable)
        if @user.present?
          redirect_to target_url
        else
          store_location(target_url)
          flash[:error] = t 'authlogic.require_user'
          redirect_to login_url
        end
      end
      format.json { render :vote }
    end
  end

  # POST /votable/:votable_id/vote
  def create
    render_with_status do
      handle_vote(@votable, params)
    end
  end

  # PUT /votable/:votable_id/vote
  def update
    render_with_status do
      handle_vote(@votable, params)
    end
  end

  # DELETE /votable/:votable_id/vote
  def destroy
    render_with_status do
      @votable.unvote voter: @user
    end
  end

  def handle_vote(votable, args)
    return false unless args.include?(:flag)
    votable.vote voter: @user, vote: args[:flag]
  end

  private

  def render_with_status
    success = yield
    status = success ? :ok : :forbidden
    @message = I18n.t("votable.status.#{status}")
    render :vote, status: status
  end
end