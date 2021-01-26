class V1::GadgetsController < ApplicationController

  ################################################################################################
  # ガジェット一覧
  ################################################################################################
  def index
    #=============================================================================================
    # 持ち物表示
    #=============================================================================================
    if params[:user_id]
      user = User.find(params[:user_id])
      gadgets = user.gadgets.page(params[:page]).per(5).order(created_at: 'DESC')
      render json: gadgets.as_json(include: [:tags,
                                            {user: {methods: :avatar_url}}],
                                    methods: :images_url)
    #=============================================================================================
    # 新着表示
    #=============================================================================================
    else
      gadgets = Gadget.all.page(params[:page]).per(5).order(created_at: 'DESC')
      render json: gadgets.as_json(include: [:tags,
                                            {user: {methods: :avatar_url}}],
                                    methods: :images_url)
    end
  end

  ################################################################################################
  # ガジェット詳細
  ################################################################################################
  def show
    gadget = Gadget.find(params[:id])
    render json: gadget.as_json(include: [:tags,
                                          {user: {methods: :avatar_url}}],
                                    methods: :images_url)
  end

  ################################################################################################
  # ガジェット新規作成
  ################################################################################################
  def create
    gadget = Gadget.new(gadget_content_params)
    sent_tags = gadget_tags_params[:tags] === nil ? [] : gadget_tags_params[:tags]
    if gadget.save
      gadget.save_tag(sent_tags)
      render json: gadget.as_json(include: [:tags,
                                            {user: {methods: :avatar_url}}],
                                    methods: :images_url)
    end
  end

  ################################################################################################
  # ガジェット更新
  ################################################################################################
  def update
    gadget = Gadget.find(params[:id])
    sent_tags = gadget_tags_params[:tags] === nil ? [] : gadget_tags_params[:tags]
    if gadget.update(gadget_content_params)
      gadget.save_tag(sent_tags)
      # imagesが空の場合に、updateメソッドで初期化
      if gadget_content_params[:images] === nil
        gadget.update(images: nil)
      end
      render json: gadget.as_json(include: [:tags,
                                            {user: {methods: :avatar_url}}],
                                    methods: :images_url)
    else
      render json: gadget.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # ガジェット削除
  ################################################################################################
  def destroy
    gadget = Gadget.find(params[:id])
    gadget.destroy
  end

  ################################################################################################
  # ガジェット検索
  ################################################################################################
  def search
    if params[:gadget_name]
      @gadgets = Gadget.search(params[:gadget_name]).order(created_at: 'DESC')
      render json: @gadgets.as_json(include: [:tags,
                                              {user: {methods: :avatar_url}}],
                                    methods: :images_url)
    end
  end
  ################################################################################################
  # プライペートメソッド
  ################################################################################################
  private
    def gadget_content_params
      params.require(:gadget).permit(:title, :good_description, :bad_description, :stars, :user_id, images: [])
    end

    def gadget_tags_params
      params.require(:gadget).permit(tags: [])
    end

end
