const trackForm = document.getElementById("trackForm");
const orderSummary = document.getElementById("orderSummary");
const summaryOrderId = document.getElementById("summaryOrderId");
const summaryDate = document.getElementById("summaryDate");
const summaryType = document.getElementById("summaryType");
const summaryStatus = document.getElementById('summaryStatus');

trackForm.addEventListener('submit', (e) => {
  e.preventDefault(); // stop page reload

  const orderId = document.getElementById('orderId').value.trim();
  if (!orderId) {
    alert('Please enter an Order ID');
    return;
  }

  // Dummy data
  summaryOrderId.textContent = orderId;
  summaryDate.textContent = new Date().toLocaleDateString();
  summaryType.textContent = 'Delivery';
  summaryStatus.textContent = 'Pending'; 

  orderSummary.style.display = 'block';
});
