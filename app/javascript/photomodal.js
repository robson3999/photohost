// photomodal.js
// Handles modal logic for photo gallery

const photos = window.photoModalPhotos || [];
let currentIdx = null;

function showModal(idx) {
  currentIdx = idx;
  document.getElementById('modal-image').src = photos[idx].url;
  document.getElementById('modal-title').textContent = photos[idx].title;
  const modal = document.getElementById('photo-modal');
  const content = document.getElementById('modal-content');
  modal.classList.remove('pointer-events-none');
  setTimeout(() => {
    modal.classList.add('opacity-100');
    modal.classList.remove('opacity-0');
    content.classList.add('scale-100');
    content.classList.remove('scale-95');
  }, 10);
  document.addEventListener('keydown', handleKey);
}

function hideModal(event) {
  const modal = document.getElementById('photo-modal');
  const content = document.getElementById('modal-content');
  modal.classList.remove('opacity-100');
  modal.classList.add('opacity-0');
  content.classList.remove('scale-100');
  content.classList.add('scale-95');
  setTimeout(() => {
    modal.classList.add('pointer-events-none');
  }, 300);
  document.removeEventListener('keydown', handleKey);
  currentIdx = null;
}

function handleKey(e) {
  if (currentIdx === null) return;
  if (e.key === 'ArrowRight') {
    if (currentIdx < photos.length - 1) {
      showModal(currentIdx + 1);
    }
  } else if (e.key === 'ArrowLeft') {
    if (currentIdx > 0) {
      showModal(currentIdx - 1);
    }
  } else if (e.key === 'Escape') {
    hideModal();
  }
}

window.showModal = showModal;
window.hideModal = hideModal;
