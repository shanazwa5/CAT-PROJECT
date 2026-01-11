<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SweetBite | PROJECT CAT201</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.6.0/css/all.min.css">

    <!-- Swiper -->
    <link rel="stylesheet"
          href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css">

    <!-- Main CSS -->
    <link rel="stylesheet" href="style.css">
</head>

<body>

<!-- HEADER -->
<header>
    <nav class="navbar section-content">
        <a href="index.jsp" class="nav-logo">
            <h2 class="logo-text">🍰 SweetBite</h2>
        </a>

        <ul class="nav-menu">
            <li class="nav-item"><a href="#home" class="nav-link">Home</a></li>
            <li class="nav-item"><a href="#about" class="nav-link">About Us</a></li>
            <li class="nav-item"><a href="menus.jsp" class="nav-link">Menu</a></li>
            <li class="nav-item"><a href="#testimonials" class="nav-link">Testimonials</a></li>
            <li class="nav-item"><a href="#contact" class="nav-link">Contact</a></li>
        </ul>

        <div class="nav-action">
            <a href="cart.jsp" class="fas fa-shopping-cart"></a>
            <a href="admin_login.jsp" class="fas fa-user"></a>
        </div>
    </nav>
</header>

<main>

<!-- HERO -->
<section class="hero-section" id="home">
    <div class="section-content">
        <div class="hero-details">
            <h2 class="title">Welcome to SweetBite</h2>
            <h3 class="subtitle">Your favorite bakery for all your sweet treats!</h3>
            <p class="descriptions">
                Freshly baked cakes and pastries made with love.
            </p>
            <div class="buttons">
                <a href="menus.jsp" class="button order-now">Order Now</a>
                <a href="#contact" class="button contact-us">Contact Us</a>
            </div>
        </div>

        <div class="hero-image-wrapper">
            <img src="images/cake-hero-section.png" alt="SweetBite Cakes">
        </div>
    </div>
</section>

<!-- ABOUT -->
<section class="about-section" id="about">
    <div class="section-content">
        <div class="about-image-wrapper">
            <img src="images/about-image.jpg" class="about-image">
        </div>

        <div class="about-details">
            <h2 class="section-title">About Us</h2>
            <p class="text">
                At SweetBite, we believe desserts should make people smile.
                Every cake is crafted with premium ingredients and passion.
            </p>

            <div class="social-link-list">
                <a href="#" class="social-link"><i class="fa-brands fa-facebook-f"></i></a>
                <a href="#" class="social-link"><i class="fa-brands fa-instagram"></i></a>
                <a href="#" class="social-link"><i class="fa-brands fa-x-twitter"></i></a>
            </div>
        </div>
    </div>
</section>

<!-- TESTIMONIALS -->
<section class="testimonials-section" id="testimonials">
    <h2 class="section-title">What Our Customers Say</h2>

    <div class="section-content">
        <div class="slider-container swiper">
            <div class="slider-wrapper">
                <ul class="testimonial-list swiper-wrapper">

                    <li class="testimonial swiper-slide">
                        <img src="images/Customer-1.jpg" class="User-image">
                        <h3 class="name">Alice Johnson</h3>
                        <i class="feedback">"Best cakes ever!"</i>
                    </li>

                    <li class="testimonial swiper-slide">
                        <img src="images/Customer-2.jpg" class="User-image">
                        <h3 class="name">Mark Lee</h3>
                        <i class="feedback">"Fast service and delicious."</i>
                    </li>

                </ul>

                <div class="swiper-pagination"></div>
                <div class="swiper-button-prev"></div>
                <div class="swiper-button-next"></div>
            </div>
        </div>
    </div>
</section>

<!-- CONTACT -->
<section class="contact-section" id="contact">
    <h2 class="section-title">Contact Us</h2>

    <div class="section-content">
        <ul class="contact-ifo-list">
            <li class="contact-info">
                <i class="fa-solid fa-location-crosshairs"></i>
                <p>SweetBite Bakery, Malaysia</p>
            </li>
            <li class="contact-info">
                <i class="fa-regular fa-envelope"></i>
                <p>sweetbite@gmail.com</p>
            </li>
            <li class="contact-info">
                <i class="fa-solid fa-phone"></i>
                <p>012-3456789</p>
            </li>
        </ul>

        <form class="contact-form">
            <input type="text" class="input-field" placeholder="Your Name" required>
            <input type="email" class="input-field" placeholder="Your Email" required>
            <textarea class="input-field" placeholder="Your Message" required></textarea>
            <button class="button submit-button">Submit</button>
        </form>
    </div>
</section>

</main>

<!-- FOOTER -->
<footer class="footer-section">
    <div class="section-content">
        <p class="copyright-text">
            &copy; 2024 SweetBite. All rights reserved.
        </p>
    </div>
</footer>

<!-- SCRIPTS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>
<script src="js/script.js"></script>

</body>
</html>