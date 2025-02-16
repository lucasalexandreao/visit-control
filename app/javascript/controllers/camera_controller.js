import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Controlador Stimulus conectado!");

    const video = document.getElementById('webcam');
    const canvas = document.getElementById('canvas');
    const ativarCameraBtn = document.getElementById('ativar-camera');
    const capturarFotoBtn = document.getElementById('capturar-foto');
    const desligarCameraBtn = document.getElementById('desligar-camera');
    const fotoInput = document.getElementById('foto-input');
    let stream = null;
  
    // Verifica se os elementos existem na página
    if (ativarCameraBtn && capturarFotoBtn && desligarCameraBtn && video && canvas && fotoInput) {
      // Ativar a câmera
      ativarCameraBtn.addEventListener('click', () => {
        navigator.mediaDevices.getUserMedia({ video: true })
          .then((mediaStream) => {
            stream = mediaStream;
            video.srcObject = stream;
            video.style.display = 'block'; // Mostrar o vídeo
            capturarFotoBtn.style.display = 'inline-block'; // Mostrar o botão de captura
            desligarCameraBtn.style.display = 'inline-block'; // Mostrar o botão de desligar câmera
            ativarCameraBtn.style.display = 'none'; // Ocultar o botão de ativar câmera
          })
          .catch((error) => {
            console.error('Erro ao acessar a webcam:', error);
            alert('Não foi possível acessar a webcam.');
          });
      });
  
      // Capturar foto
      capturarFotoBtn.addEventListener('click', () => {
        const context = canvas.getContext('2d');
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
        context.drawImage(video, 0, 0, canvas.width, canvas.height);
  
        // Converter a imagem para um arquivo e atribuir ao campo de upload
        canvas.toBlob((blob) => {
          const file = new File([blob], 'foto.png', { type: 'image/png' });
          const dataTransfer = new DataTransfer();
          dataTransfer.items.add(file);
          fotoInput.files = dataTransfer.files;
        }, 'image/png');
  
        // Desligar a câmera após capturar a foto
        desligarCamera();
      });
  
      // Desligar a câmera
      desligarCameraBtn.addEventListener('click', () => {
        desligarCamera();
      });
  
      // Função para desligar a câmera
      function desligarCamera() {
        if (stream) {
          stream.getTracks().forEach(track => track.stop()); // Parar todas as tracks da câmera
          video.srcObject = null; // Limpar o vídeo
          video.style.display = 'none'; // Ocultar o vídeo
          capturarFotoBtn.style.display = 'none'; // Ocultar o botão de captura
          desligarCameraBtn.style.display = 'none'; // Ocultar o botão de desligar câmera
          ativarCameraBtn.style.display = 'inline-block'; // Mostrar o botão de ativar câmera novamente
        }
      }
    } else {
      console.error('Elementos da câmera não encontrados na página.');
    }
  }
}
