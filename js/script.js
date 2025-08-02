document.addEventListener("DOMContentLoaded", () => {
    
    cargarBodegas();
    cargarMonedas();

    document.getElementById("bodega").addEventListener("change", cargarSucursales);
    document.getElementById("guardarBtn").addEventListener("click", validarFormulario);
});


async function validarFormulario() {
    const codigo = document.getElementById("codigo").value.trim();
    const nombre = document.getElementById("nombre").value.trim();
    const bodega = document.getElementById("bodega").value;
    const sucursal = document.getElementById("sucursal").value;
    const moneda = document.getElementById("moneda").value;
    const precio = document.getElementById("precio").value.trim();
    const descripcion = document.getElementById("descripcion").value.trim();
    const materiales = Array.from(document.querySelectorAll('input[name="material[]"]:checked')).map(el => el.value);

    if (codigo === "") {
        alert("El código del producto no puede estar en blanco.");
        return;
    }

    if (codigo.length < 5 || codigo.length > 15) {
    alert("El código del producto debe tener entre 5 y 15 caracteres.");
    return;
    }

    if (!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]+$/.test(codigo)) {
        alert("El código del producto debe contener letras y números, sin símbolos ni espacios.");
        return;
    }

    const existeCodigo = await verificarCodigo(codigo);
    if (existeCodigo) {
        alert("El código del producto ya está registrado.");
        return;
    }

    if (nombre === "") {
        alert("El nombre del producto no puede estar en blanco.");
        return;
    }

    if (nombre.length < 2 || nombre.length > 50) {
        alert("El nombre del producto debe tener entre 2 y 50 caracteres.");
        return;
    }

    if (precio === "") {
        alert("El precio del producto no puede estar en blanco.");
        return;
    }

    if (!/^\d+(\.\d{1,2})?$/.test(precio) || parseFloat(precio) <= 0) {
        alert("El precio del producto debe ser un número positivo con hasta dos decimales.");
        return;
    }

    if (materiales.length < 2) {
        alert("Debe seleccionar al menos dos materiales para el producto.");
        return;
    }

    if (bodega === "") {
        alert("Debe seleccionar una bodega.");
        return;
    }

    if (sucursal === "") {
        alert("Debe seleccionar una sucursal para la bodega seleccionada.");
        return;
    }

    if (moneda === "") {
        alert("Debe seleccionar una moneda para el producto.");
        return;
    }

    if (descripcion === "") {
        alert("La descripción del producto no puede estar en blanco.");
        return;
    }

    if (descripcion.length < 10 || descripcion.length > 1000) {
        alert("La descripción del producto debe tener entre 10 y 1000 caracteres.");
        return;
    }

    enviarFormulario({
        codigo, nombre, bodega, sucursal, moneda,
        precio, descripcion, materiales
    });
}


function cargarBodegas() {
    console.log("entro");
    fetch("obtener_bodegas.php")
        .then(res => res.json())
        .then(res => {
            let select = document.getElementById("bodega");
            res.forEach(b => {
                const option = document.createElement("option");
                option.value = b.id;
                option.textContent = b.nombre;
                select.appendChild(option);
            });
            
        });
}

function cargarSucursales() {
    const bodegaId = document.getElementById("bodega").value;
    const select = document.getElementById("sucursal");
    select.innerHTML = '<option value=""> </option>';

    if (bodegaId === "") return;

    fetch("obtener_sucursales.php?bod_id=" + bodegaId)
        .then(res => res.json())
        .then(data => {
            data.forEach(s => {
                let option = document.createElement("option");
                option.value = s.id;
                option.textContent = s.nombre;
                select.appendChild(option);
            });
        });
}

function cargarMonedas() {
    fetch("obtener_monedas.php")
        .then(res => res.json())
        .then(data => {
            const select = document.getElementById("moneda");
            data.forEach(m => {
                const option = document.createElement("option");
                option.value = m.id;
                option.textContent = m.nombre;
                select.appendChild(option);
            });
        });
}

async function verificarCodigo(codigo) {
    const res = await fetch("verificar_codigo.php?pro_codigo=" + encodeURIComponent(codigo));
    const data = await res.json();
    return data.existe; 
}

function enviarFormulario(data) {
    fetch("guardar.php", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data)
    })
    .then(res => res.json())
    .then(resp => {
        if (resp.success) {
            alert("Producto guardado exitosamente.");
            document.getElementById("formularioProducto").reset();
        } else {
            alert("Error al guardar el producto: " + resp.error);
        }
    })
    .catch(err => {
        alert("Error al conectar con el servidor.");
        console.error(err);
    });
}
