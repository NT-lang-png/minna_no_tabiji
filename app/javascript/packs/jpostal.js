function jpostal() {
  $('#zipcode').jpostal({
    postcode : ['#zipcode'],
    address : {
      '#destination_address': '%3%4%5'
    }
  });
}
$(document).on("turbolinks:load", jpostal);