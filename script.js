// ================================
// NAVBAR (SAFE)
// ================================
const menuOpenButton = document.querySelector("#menu-open-button");
const menuCloseButton = document.querySelector("#menu-close-button");
const navLinks = document.querySelectorAll(".nav-menu .nav-link");

if (menuOpenButton && menuCloseButton) {
    menuOpenButton.addEventListener("click", () => {
        document.body.classList.toggle("show-mobile-menu");
    });

    menuCloseButton.addEventListener("click", () => {
        document.body.classList.remove("show-mobile-menu");
    });

    navLinks.forEach(link => {
        link.addEventListener("click", () => {
            document.body.classList.remove("show-mobile-menu");
        });
    });
}

// ================================
// SWIPER (SAFE)
// ================================
if (typeof Swiper !== "undefined") {
    new Swiper(".slider-wrapper", {
        loop: true,
        spaceBetween: 25,
        pagination: {
            el: ".swiper-pagination",
            clickable: true,
            dynamicBullets: true,
        },
        navigation: {
            nextEl: ".swiper-button-next",
            prevEl: ".swiper-button-prev",
        },
        breakpoints: {
            0: { slidesPerView: 1 },
            768: { slidesPerView: 2 },
            1024: { slidesPerView: 3 },
        },
    });
}