// require active_admin/base // you suck for importing old jquery!
//= require jquery
//= require jquery-ui
//= require jquery_ujs

/* Active Admin JS */

$(function(){
  $(".datepicker").datepicker({dateFormat: 'yy-mm-dd'});

  $(".clear_filters_btn").click(function(){
    window.location.search = "";
    return false;
  });
  
