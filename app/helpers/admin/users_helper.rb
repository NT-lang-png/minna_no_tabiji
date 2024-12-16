module Admin::UsersHelper

  # ステータスを返す
  def user_status(user)
    user.is_active ? '有効' : '退会'
  end

  # ステータスに応じたCSSクラスを返す
  def user_status_class(user)
    user.is_active ? 'text-success' : 'text-muted'
  end

end

