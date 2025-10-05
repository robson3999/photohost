// photomodal.js
// Handles modal logic for photo gallery

function showModal(idx) {
  let photos = window.photoModalPhotos || [];
  let currentIdx = idx;
  if (photos.length == 0) return;

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
  document.addEventListener('keydown', handleKey, currentIdx, photos.length);
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
}

function handleKey(e, currentIdx, photosLength) {
  if (currentIdx === null) return;
  if (e.key === 'ArrowRight') {
    if (currentIdx < photosLength - 1) {
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
