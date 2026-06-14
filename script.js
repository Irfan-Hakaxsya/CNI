const express = require("express");
const path = require("path"); // Modul ini bantu kita cari lokasi fail yang tepat
const app = express();

app.get("/", (req, res) => {
    // res.sendFile digunakan untuk memaparkan fail HTML kepada pengguna
    // Tukar "CNI Web.html" jika nama fail anda berbeza
    res.sendFile(path.join(__dirname, "CNI Web.html")); 
});

app.listen(3000, () => {
    console.log("Server berjalan di port 3000");
});
