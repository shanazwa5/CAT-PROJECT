// Fetch 3 latest reviews from Oracle APEX

// Target UL inside testimonial section
const swiperWrapper = document.getElementById('home-review-slider');

// Oracle APEX REST API (order by latest date)
const apiUrl = 'https://oracleapex.com/ords/my_workhuu/review/reviews_by_date';

fetch(apiUrl)
  .then(response => response.json())
  .then(data => {
    // APEX returns data in items[]
    const reviews = data.items;

    // Take only 3 latest reviews
    const homeReviews = reviews.slice(0, 3);

    // Clear existing content
    swiperWrapper.innerHTML = '';

    // Insert reviews into slider
    homeReviews.forEach(review => {
      const li = document.createElement('li');
      li.className = 'testimonial swiper-slide';

      li.innerHTML = 
        <div class="review-card">
          <h3 class="name">${review.customer_name}</h3>
          <p class="rating">Rating: ${review.rating} ⭐</p>
          <i class="feedback">"${review.review_comment}"</i>
        </div>
      ;

      swiperWrapper.appendChild(li);
    });

    // Initialize Swiper AFTER data loaded
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