
document.addEventListener('turbo:load', function() {
    document.querySelector('#cpf').addEventListener('input', function(event) {
        console.log("TO AQUI CPF");
        var input = event.target;
        var value = input.value.replace(/\D/g, ''); // Remove caracteres não númericos

        // Limita o número de dígitos a 11
        if (value.length > 11) {
            value = value.substring(0, 11);
        }

        //Aplica a formatação de CPF após o usuário colocar os 11 digitos: xxx.xxx.xxx-xx
        value = value.replace(/(\d{3})(\d{3})(\d{3})(\d{2})/, '$1.$2.$3-$4');
        
        //Atualiza o campo do formulário com a formatação
        input.value = value;
    });
    document.querySelector('#rg').addEventListener('input', function(event) {
        console.log("TO AQUI RG");
        var input = event.target;
        var value = input.value.replace(/\D/g, ''); //Remove caracteres não númericos

        //Limita o número de dígitos a 9
        if (value.length > 9) {
            value = value.substring(0, 9);
        }

        //Aplica a formatação de RG: xxx.xxx.xxx
        value = value.replace(/(\d{3})(\d{3})(\d{3})/, '$1.$2.$3');
        
        //Atualiza o campo do formulário com a formatação
        input.value = value;
    });
    document.querySelector('#phone').addEventListener('input', function(event) {
        var input = event.target;
        var value = input.value.replace(/\D/g, ''); //Remove caracteres não númericos

        //Limita o número de dígitos a 11
        if (value.length > 11) {
            value = value.substring(0, 11);
        }

        //Aplica a formatação de Celular: (xx) x xxxx-xxxx
        value = value.replace(/(\d{2})(\d{1})(\d{4})(\d{4})/, '($1) $2 $3-$4');
        
        //Atualiza o campo do formulário com a formatação
        input.value = value;
    });

});


