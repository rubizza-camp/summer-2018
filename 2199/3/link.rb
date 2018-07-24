# class link
class Link
  def index
    @link = Link.all.order('created_at DESC')
  end

  def new
    @link = Link.new

  end

  def create
    @link = Link.new(link_params)
    @link.save
  end

  def show
    @link = Link.find(params[:id])
  end

  def destroy
    @link.destroy
  end

  private

  def link_params
    params.require(:link).permit(:name)
  end

  def find_age
    @age = Link.find(params[:id])
  end
end