window.addEventListener("load", function(){
  var index = document.getElementById(document.location.search.slice(-1));
  if(!!index){
    index.classList.add('user-index__item--active');
  }

})
