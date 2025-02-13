import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Controlador Stimulus conectado!");

    const video = document.getElementById('webcam');
    const canvas = document.getElementById('canvas');
    const ativarCameraBtn = document.getElementById('activate-camera');
    const capturarFotoBtn = document.getElementById('capture-photo');
    const fotoInput = document.getElementById('photo-input');

    if (!video || !canvas || !ativarCameraBtn || !capturarFotoBtn || !fotoInput) {
      console.error("Elementos da câmera não encontrados!");
      return;
    }

    let stream = null;

    ativarCameraBtn.addEventListener('click', () => {
      navigator.mediaDevices.getUserMedia({ video: true })
        .then((mediaStream) => {
          stream = mediaStream;
          video.srcObject = stream;
          video.style.display = 'block';
          capturarFotoBtn.style.display = 'block';
          ativarCameraBtn.style.display = 'none';
        })
        .catch((error) => {
          console.error('Erro ao acessar a webcam:', error);
          alert('Não foi possível acessar a webcam.');
        });
    });

    capturarFotoBtn.addEventListener('click', () => {
      const context = canvas.getContext('2d');
      canvas.width = video.videoWidth;
      canvas.height = video.videoHeight;
      context.drawImage(video, 0, 0, canvas.width, canvas.height);

      canvas.toBlob((blob) => {
        const file = new File([blob], 'foto.png', { type: 'image/png' });
        const dataTransfer = new DataTransfer();
        dataTransfer.items.add(file);
        fotoInput.files = dataTransfer.files;
      }, 'image/png');

      if (stream) {
        stream.getTracks().forEach(track => track.stop());
        video.srcObject = null;
        video.style.display = 'none';
        capturarFotoBtn.style.display = 'none';
        ativarCameraBtn.style.display = 'block';
      }
    });
  }
}
