

// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

// bootstrap導入
import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"; 

Rails.start()  // 1つだけ残す
Turbolinks.start()
ActiveStorage.start()

// jquery導入
require('jquery')
require("@nathanvda/cocoon")



//　ヘッダー　ユーザーメニュー
document.addEventListener('turbolinks:load', function() {
  // turbolinks:load イベントでのJavaScriptの再実行
  // ここにページロード時に実行したいJavaScriptコードを記述する
  // 例：カテゴリのドロップダウンメニューの制御やスライドショーの設定など

  //ヘッダー　メニュー
  $('.nav-menu-trigger').on('click', function(event) {
    $(this).toggleClass('active');
    $('#nav-menu').fadeToggle();
    $('#user-icon').fadeToggle();
    event.preventDefault();
  });

});
