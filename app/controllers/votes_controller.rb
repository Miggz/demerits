class VotesController < ApplicationController
  before_filter :set_user
  skip_before_action :verify_authenticity_token
  load_polymorphic_from_url :votable

  # GET /votable/:votable_id/vote
  def show
    respond_to do |format|
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
    @user.vote votable, flag: args[:flag].to_bool
  end

  private

  def render_with_status
    success = yield
    status = success ? :ok : :forbidden
    render :vote, status: status
  end
end
