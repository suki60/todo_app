// hover lists
$(".test").hover(function(){
  $(this).css("box-shadow", "0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19)");
  console.log(this);
},function(){
  $(this).css("box-shadow", "0 0 0");
});
