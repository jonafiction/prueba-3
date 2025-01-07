console.log("Página cargada correctamente.");

document.addEventListener("DOMContentLoaded", () => {
  const header = document.querySelector("h1");
  if (header) {
    header.style.color = "#007BFF";
    console.log("El color del encabezado se ha actualizado dinámicamente.");
  }
});
