function handleDeleteConfirmation() {
    const deleteButtons = document.querySelectorAll('.delete-button');

    deleteButtons.forEach(function(button) {
        button.addEventListener("click", function(event) {
            const confirmation = confirm('Você tem certeza de que deseja remover este item?');
            if (!confirmation) {
                event.preventDefault(); 
            }
        });
    });
}

// Garante que a função seja chamada corretamente em mudanças de página com Turbo
document.addEventListener("turbo:load", handleDeleteConfirmation);

