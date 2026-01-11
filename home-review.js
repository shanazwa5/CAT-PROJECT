// home-review.js

// Target UL inside testimonial section
const swiperWrapper = document.getElementById('home-review-slider');

fetch('http://localhost:3000/api/reviews')
  .then(response => response.json())
  .then(data => {
    // Clear existing dummy content
    swiperWrapper.innerHTML = '';

    data.forEach(review => {
      const li = document.createElement('li');
      li.className = 'testimonial swiper-slide';

      li.innerHTML = `
        <div class="review-card">
          <h3 class="name">${review.customer_name}</h3>
          <p class="rating">Rating: ${review.rating} ⭐</p>
          <i class="feedback">"${review.review_comment}"</i>
        </div>
      `;

      swiperWrapper.appendChild(li);
    });

    // Initialize Swiper AFTER reviews loaded
    new Swiper('.swiper', {
      loop: true,
      pagination: {
        el: '.swiper-pagination',
        clickable: true
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev'
      }
    });
  })
  .catch(error => {
    console.error('Error loading reviews:', error);
  });