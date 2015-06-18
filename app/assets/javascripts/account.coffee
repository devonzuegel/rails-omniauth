$ ->
  if gon.controller is "accounts"
    $("select#account_theme").change ->
      $("body").toggleClass("dark light")