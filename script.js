const navLinks = document.querySelectorAll(".nav-menu .nav-link");
const menuOpenButton = document.querySelector("#menu-open-button");
const menuCloseButton = document.querySelector("#menu-close-button");

menuOpenButton.addEventListener("click", () => {
  //Toggle mobile menu visibility
  document.body.classList.toggle("show-mobile-menu");
});

// Close mobile menu when close button is clicked
menuCloseButton.addEventListener("click", () => menuOpenButton.click());

//Close mobile menu when any nav link is clicked
navLinks.forEach((link) => {
  link.addEventListener("click", () => menuOpenButton.click());
});


//Initialize Swiper
const swiper = new Swiper('.slider-wrapper', {
  loop: true,
  spaceBetween: 25,
  // If we need pagination
  pagination: {
    el: '.swiper-pagination',
    clickable: true,
    dynamicBullets: true,
  },

  // Navigation arrows
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },

  breakpoints: {
    0: {
      slidesPerView: 1,
    },
    768: {
      slidesPerView: 2,
    },
    1024: {
      slidesPerView: 3,
    },
  },
});

//Search and Filter Functionz

// Customize function
const addToCartBtn = document.querySelector(".btn");

addToCartBtn.addEventListener("click", () => {
  const cakeName = document.querySelector(".cake-name").textContent;
  const size = document.querySelector("#size").value;
  const decorations = document.querySelector("#decorations").value;
  const candles = document.querySelector("#candles").value;
  const message = document.querySelector("#message").value;

  const cartItem = {
    cakeName,
    size,
    decorations,
    candles,
    message
  };

  console.log("Added to cart:", cartItem);
  alert(`${cakeName} added to cart!`);
});
