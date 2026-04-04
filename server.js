const express = require("express");
const axios = require("axios");
const cors = require("cors");
const path = require("path");

const app = express();
app.use(cors());
app.use(express.static(path.join(__dirname, "public")));

app.get("/processo/:numero", async (req, res) => {
  const numero = req.params.numero;

  try {
    const response = await axios.get(
      "https://comunicaapi.pje.jus.br/api/v1/comunicacao",
      {
        params: {
          numeroProcesso: numero,
          meio: "D"
        },
        headers: {
          accept: "application/json"
        }
      }
    );

    res.json(response.data);
  } catch (error) {
    console.error(error.message);
    res.status(500).json({ erro: "Erro ao buscar dados" });
  }
});

app.get("*", (_, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.listen(3000, () => {
  console.log("Servidor rodando em http://localhost:3000");
});
