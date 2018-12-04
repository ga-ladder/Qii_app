window.addEventListener("load",function(){
  var index = $(".main__MDcontent")[0];
  if(!!index){
    // [[a_tag, 'text'],[]...]
    list = $.makeArray($("h1,h2,h3,h4,h5,h6")).map(function(element){
      indexElement = document.createElement("a")
      if (!element.children[1]){
        indexElement.href = "#"
      }else{
      indexElement.href = element.children[1]
      }
      indexElement.innerHTML = element.textContent
      return indexElement
    });
    tocNav = $("#tocNav")
    list.forEach(function(val,index,ar){
      tocNav.append($('<li/>').append(val))
    });
  }
})
