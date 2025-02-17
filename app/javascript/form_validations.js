function applyMask(selector, maxLength, maskPattern) {
    document.querySelectorAll(selector).forEach((input) => {
        input.addEventListener("input", function(event) {
            let value = event.target.value.replace(/\D/g, ""); // Remove tudo que não for número

            // Limita o número de dígitos
            if (value.length > maxLength) {
                value = value.substring(0, maxLength);
            }

            // Aplica a máscara usando regex
            value = value.replace(maskPattern.regex, maskPattern.format);

            event.target.value = value; // Atualiza o input com a máscara
        });
    });
}

function setupFormMasks() {
    applyMask("#cpf", 11, { regex: /(\d{3})(\d{3})(\d{3})(\d{2})/, format: "$1.$2.$3-$4" });
    applyMask("#rg", 9, { regex: /(\d{3})(\d{3})(\d{3})/, format: "$1.$2.$3" });
    applyMask("#phone", 11, { regex: /(\d{2})(\d{1})(\d{4})(\d{4})/, format: "($1) $2 $3-$4" });
}

// Aplica máscaras ao carregar a página
document.addEventListener("turbo:load", setupFormMasks);

// Aplica máscaras após o Turbo re-renderizar a página (após erro no formulário)
document.addEventListener("turbo:render", setupFormMasks);
