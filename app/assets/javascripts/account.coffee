$ ->
  if gon.controller is "accounts"
    alert "laksdfjlsakdfjlaksdjf"
    $("select#account_theme").change ->
      $("body").toggleClass("dark light")