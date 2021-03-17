class V2::BoardsController < ApplicationController
  
  ################################################################################################
  # 掲示板一覧
  ################################################################################################
  def index
    #=============================================================================================
    # 掲示板の種類別表示
    #=============================================================================================
    if params[:board_type]
      @boards = Board.includes({images_attachments: :blob},
                                {user: {avatar_attachment: :blob}},
                                :tags,
                                {board_comments: [{user: {avatar_attachment: :blob}},
                                                  {images_attachments: :blob}]}).where(board_type: params[:board_type]).order(created_at: "DESC").page(params[:page]).per(5)
      render json: @boards.as_json(include: [{user: {methods: :avatar_url,
                                                      except: [:uid, :email]}},
                                              :tags,
                                              {board_comments: {include: {user: {methods: :avatar_url,
                                                                                  except: [:uid, :email]}},
                                                                methods: :images_url}}],
                                    methods: :images_url)
    #=============================================================================================
    # 新着表示 
    #=============================================================================================
    else
      @boards = Board.includes({images_attachments: :blob},
                                {user: {avatar_attachment: :blob}},
                                :tags,
                                {board_comments: [{user: {avatar_attachment: :blob}},
                                                  {images_attachments: :blob}]}).page(params[:page]).per(5).order(created_at: "DESC")
      render json: @boards.as_json(include: [{user: {methods: :avatar_url,
                                                      except: [:uid, :email]}},
                                              :tags,
                                              {board_comments: {include: {user: {methods: :avatar_url,
                                                                                  except: [:uid, :email]}},
                                                                methods: :images_url}}],
                                    methods: :images_url)
    end
  end

  ################################################################################################
  # 掲示板詳細
  ################################################################################################
  def show
    @board = Board.includes({images_attachments: :blob},
                            {user: {avatar_attachment: :blob}},
                            :tags,
                            {board_comments: [{user: {avatar_attachment: :blob}},
                                              {images_attachments: :blob}]}).find(params[:id])
    render json: @board.as_json(include: [{user: {methods: :avatar_url,
                                                  except: [:uid, :email]}},
                                            :tags,
                                            {board_comments: {include: {user: {methods: :avatar_url,
                                                                                except: [:uid, :email]}},
                                                              methods: :images_url}}],
                                methods: :images_url)
  end

  ################################################################################################
  # 掲示板新規作成
  ################################################################################################
  def create
    # uidが一致する場合のみ処理を実行
    return if User.find(board_content_params[:user_id]).uid != board_content_params[:uid]

    @board = Board.new(board_content_params.except(:uid))
    sent_tags = board_tags_params[:tags] === nil ? [] : board_tags_params[:tags]
    if @board.save
      @board.save_tag(sent_tags)
      render json: @board.as_json(include: [{user: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                                            :tags,
                                            {board_comments: {include: {user: {methods: :avatar_url,
                                                                                except: [:uid, :email]}},
                                                              methods: :images_url}}],
                                    methods: :images_url),
              status: :created
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # 掲示板更新
  ################################################################################################
  def update
    @board = Board.find(params[:id])

    # uidが一致する場合のみ処理を実行
    return if @board.user.uid != board_content_params[:uid]

    sent_tags = board_tags_params[:tags] === nil ? [] : board_tags_params[:tags]
    if @board.update(board_content_params.except(:uid))
      @board.save_tag(sent_tags)
      # imagesが空の場合に、updateメソッドで初期化
      if board_content_params[:images] === nil
        @board.update(images: nil)
      end
      render json: @board.as_json(include: [{user: {methods: :avatar_url,
                                                    except: [:uid, :email]}},
                                  :tags,
                                  {board_comments: {include: {user: {methods: :avatar_url,
                                                                      except: [:uid, :email]}},
                                                    methods: :images_url}}],
                          methods: :images_url)
    else
      render json: @board.errors, status: :unprocessable_entity
    end
  end

  ################################################################################################
  # 掲示板削除
  ################################################################################################
  def destroy
    @board = Board.find(params[:id])

    # uidが一致する場合のみ処理を実行
    return if @board.user.uid != params[:uid]

    @board.destroy
  end

  ################################################################################################
  # 掲示板検索
  ################################################################################################
  def search
    if params[:board_name]
      @boards = Board.search(params[:board_name]).order(created_at: 'DESC')
      render json: @boards.as_json(include: [{user: {methods: :avatar_url,
                                                      except: [:uid, :email]}},
                                            :tags,
                                            {board_comments: {include: {user: {methods: :avatar_url,
                                                                                except: [:uid, :email]}},
                                                              methods: :images_url}}],
                                    methods: :images_url)
    end
  end

  ################################################################################################
  # プライベートメソッド
  ################################################################################################
  private

    def board_content_params
      params.require(:board).permit(:title, :description, :board_type, :user_id, :uid, images: [])
    end

    def board_tags_params
      params.require(:board).permit(tags: [])
    end

end
