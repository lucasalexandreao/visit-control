function applyCpfMask(selector) {
    document.querySelectorAll(selector).forEach((input) => {
        input.addEventListener("input", function(event) {
            let value = event.target.value.replace(/\D/g, ""); // Remove tudo que não for número

            // Limita o número de dígitos a 11
            if (value.length > 11) {
                value = value.substring(0, 11);
            }

            // Aplica a máscara no formato xxx.xxx.xxx-xx
            value = value.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, "$1.$2.$3-$4");

            event.target.value = value; // Atualiza o input com a máscara
        });
    });
}

function setupCpfSearchMask() {
    applyCpfMask("#cpf_search");
}

// Aplica a máscara ao carregar a página
document.addEventListener("turbo:load", setupCpfSearchMask);

// Aplica a máscara após o Turbo re-renderizar a página (após erro no formulário)
document.addEventListener("turbo:render", setupCpfSearchMask);
