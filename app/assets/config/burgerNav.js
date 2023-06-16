document.addEventListener('DOMContentLoaded', (event) => {
    document.getElementById("hamburger").addEventListener("click", function() {
      var x = document.getElementsByClassName("navbar-nav")[0];
      if (x.style.display === "none") {
        x.style.display = "block";
        x.classList.add("vertical");
      } else {
        x.style.display = "none";
        x.classList.remove("vertical");
      }
    });
    
    // Vérifiez si la fenêtre est agrandie
    window.addEventListener('resize', function(){
      var nav = document.getElementsByClassName("navbar-nav")[0];
      var w = window.innerWidth;
      if(w > 1100) {
        nav.style.display = "flex"; // rétablir l'affichage
        nav.classList.remove("vertical");
      } else {
        nav.style.display = "none";
      }
    });
  });
  