module FirebaseAuthentication
  extend ActiveSupport::Concern

  # トークンを検証
  def authorize
    access_token = extract_access_token_from_header
    if (extract_access_token_from_header != ENV['GUEST_UID'])
      @current_user_firebase_uid = access_token.first['user_id']
    else
      @current_user_firebase_uid = access_token
    end
  end

  # トークンから取得したuidを使用して、ユーザーモデルを取得
  def current_user
    return unless @current_user_firebase_uid
    @current_user ||= User.find_by(uid: @current_user_firebase_uid)
  end

  # HTTPヘッダーからトークンを抽出して検証
  def extract_access_token_from_header
    token = request.headers['Authorization'].split(" ").last
    if (token != "guest_token")
      Firebase::Auth::IDTokenKeeper::IDToken.new(token).verified_id_token
    else
      return ENV['GUEST_UID']
    end
  end

end