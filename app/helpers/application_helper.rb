module ApplicationHelper
  
#ヘッダーのメソッド　PC版
  def render_navigation
    if admin_signed_in?
      render_admin_nav
    elsif user_signed_in?
      if current_user.guest_user?
        render_guestuser_nav
      else
      render_user_nav
      end
    else
      render_guest_nav
    end
  end

  #ユーザーログイン中
  def render_user_nav
    # ボタンとボタンの間に | を追加する=nav-separator application.scssに記述
    #content_tag(:li, class: "nav-item me-5") do
      #content_tag(:span, "ようこそ、#{current_user.handle_name}さん！", class: "navbar-text")
    #end 
    link_to_menu("使い方", tutorials_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("しおり一覧", itineraries_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("しおり作成", new_itinerary_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("マイページ", user_path(current_user)) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("ログアウト", destroy_user_session_path, method: :delete)
  end

  #アドミンログイン中
  def render_admin_nav
    content_tag(:li, class: "nav-item me-5") do
      content_tag(:span, "現在は管理者用ログインページです", class: "navbar-text text-danger")
    end +
    link_to_menu("投稿一覧", admin_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("ユーザー一覧", admin_users_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("コメント一覧", admin_post_comments_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("ログアウト", destroy_admin_session_path, method: :delete)
  end

  #ゲストユーザーログイン中
  def render_guestuser_nav
    content_tag(:li, class: "nav-item me-5") do
      content_tag(:span, "ゲストログイン中です！", class: "navbar-text")
    end +
    link_to_menu("使い方", tutorials_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("しおり一覧", itineraries_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("しおり作成", new_itinerary_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("マイページ", user_path(current_user)) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("ログアウト", destroy_user_session_path, method: :delete)
  end


  #未ログイン
  def render_guest_nav
    link_to_menu("ゲストログイン", users_guest_sign_in_path, method: :post) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("ログイン", new_user_session_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("新規登録", new_user_registration_path) +
    content_tag(:span, "|", class: "nav-separator") +
    link_to_menu("しおり一覧", itineraries_path)
  end

  # bootstrapのクラスはこちらに記述, btn-hoverのcssはjavascript/application.scssに記述
  def link_to_menu(text, path, method: nil)
    content_tag(:li, class: "nav-item") do
      link_to text, path, class: "btn mx-3 btn-hover", method: method
    end
  end



#ヘッダーのメソッド　モバイル版
  def render_navigation_mobile
    if admin_signed_in?
      render_admin_nav_mobile
    elsif user_signed_in?
      if current_user.guest_user?
        render_guestuser_nav_mobile
      else
      render_user_nav_mobile
      end
    else
      render_guest_nav_mobile
    end
  end

  #ユーザーログイン中
  def render_user_nav_mobile
    link_to_menu("使い方", tutorials_path) +
    link_to_menu("しおり一覧", itineraries_path) +
    link_to_menu("しおり作成", new_itinerary_path) +
    link_to_menu("マイページ", user_path(current_user)) +
    render_dropdown("アカウント", [["ログアウト", destroy_user_session_path, :delete]])
  end


  #管理者ログイン中
  def render_admin_nav_mobile
    content_tag(:li, class: "nav-item me-5") do
      content_tag(:span, "管理者ログイン中です！", class: "navbar-text")
    end
    link_to_menu("投稿一覧", admin_path) +
    link_to_menu("ユーザー一覧", admin_users_path) +
    link_to_menu("コメント一覧", admin_post_comments_path) +
    render_dropdown("アカウント", [["ログアウト", destroy_admin_session_path, :delete]])
  end

  #ゲストログイン中
  def render_guestuser_nav_mobile
    link_to_menu("使い方", tutorials_path) +
    link_to_menu("しおり一覧", itineraries_path) +
    link_to_menu("しおり作成", new_itinerary_path) +
    link_to_menu("マイページ", user_path(current_user)) +
    render_dropdown("アカウント", [["ログアウト", destroy_user_session_path, :delete]])
  end



  # bootstrapのクラスはこちらに記述, btn-hoverのcssはjavascript/application.scssに記述
  def link_to_menu_mobile(text, path, method: nil)
    content_tag(:li, class: "nav-item") do
      link_to text, path, class: "nav-link btn mx-3 btn-hover", method: method
    end
  end

  # ドロップダウンメニュー
  def render_dropdown(label, items)
    content_tag(:li, class: "nav-item dropdown") do
      content_tag(:div, class: "nav-link dropdown-toggle", id: "navbarDropdownMenuLink",
                         role: "button", data: { toggle: "dropdown" }, aria: { haspopup: "true", expanded: "false" }) +
      content_tag(:div, class: "dropdown-menu", aria: { labelledby: "navbarDropdownMenuLink" }) do
        items.map do |text, path, method|
          link_to text, path, class: "dropdown-item", method: method
        end.join.html_safe
      end
    end
  end


end