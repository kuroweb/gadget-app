class V1::GadgetsController < ApplicationController

  def index
    gadgets = Gadget.all.page(params[:page]).per(5).order(created_at: 'DESC')
    render json: gadgets.as_json(include: [:tags,
                                          {user: {methods: :avatar_url}}],
                                  methods: :images_url)
  end

  def show

  end

  def create
    gadget = Gadget.new(gadget_content_params)
    sent_tags = gadget_tags_params[:tags] === nil ? [] : gadget_tags_params[:tags]
    if gadget.save
      gadget.save_tag(sent_tags)
      render json: gadget
    end
  end

  def update

  end

  def destroy

  end

  private
    def gadget_content_params
      params.require(:gadget).permit(:title, :good_description, :bad_description, :stars, :user_id, images: [])
    end

    def gadget_tags_params
      params.require(:gadget).permit(tags: [])
    end

end
