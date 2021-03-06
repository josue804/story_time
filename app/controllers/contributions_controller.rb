class ContributionsController < ApplicationController

  def show
    @story = Story.find(params[:story_id])

    @contribution = Contribution.new
    @contributions = @story.contributions.all
  end

  def new
    @story = Story.find(params[:story_id])

    @contribution = Contribution.new
    @image = "Pepe/#{rand(44)}.jpg"
  end

  def destroy
    @story = Story.find(params[:story_id])
    @contribution = Contribution.find(params[:id])
    @contribution.destroy
    redirect_to story_path(@story)
  end

  def create
    @story = Story.find(params[:story_id])
    @contribution = @story.contributions.new(contribution_params)
    @contribution.user_id=current_user.id if current_user
    if @contribution.save
      flash[:notice] = "Sentence added!"
      redirect_to story_path(@story)
    else
      render :new
    end
  end

  def edit
    @contribution = Contribution.find(params[:id])
  end

  private
  def contribution_params
    params.require(:contribution).permit(:sentence, :image)
  end
end
