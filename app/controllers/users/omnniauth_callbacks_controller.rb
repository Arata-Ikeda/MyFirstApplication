class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    # Googleからの認証情報を取得
    auth = request.env["omniauth.auth"]

    # Userモデルのfrom_omniauthメソッドを呼び出し、ユーザーを検索または作成
    @user = User.from_omniauth(auth)

    if @user.persisted? # ユーザーがデータベースに保存済み（または新規作成に成功）
      sign_in_and_redirect @user, event: :authentication # ユーザーをログインさせてリダイレクト
      set_flash_message(:notice, :success, kind: "Google") if is_navigational_format?
    else
      # ユーザーの保存に失敗した場合
      # 例えば、バリデーションエラーなどで保存できなかった場合
      session["devise.google_oauth2_data"] = request.env["omniauth.auth"].except("extra") # セッションに情報を保持
      redirect_to new_user_registration_url, alert: @user.errors.full_messages.join(", ") # 登録ページへリダイレクト
    end
  end

  # 認証失敗時の処理（オプション）
  # def failure
  #   redirect_to root_path, alert: "Google認証に失敗しました。"
  # end
end