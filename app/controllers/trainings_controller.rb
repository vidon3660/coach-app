class TrainingsController < AuthenticatedController
  def show
    @training = Training.find(params[:id])
  end

  def destroy
    @training = Training.find(params[:id])
    @training.close_at = DateTime.now
    @training.save
    redirect_to root_path, notice: "You close training."
  end
end
