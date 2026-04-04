const express = require("express");
const axios = require("axios");
const cors = require("cors");
const path = require("path");

const app = express();
app.use(cors());
app.use(express.static(path.join(__dirname, "public")));

app.get("/processo/:numero", async (req, res) => {
  const { numero } = req.params;

  try {
    const { data } = await axios.get("https://comunicaapi.pje.jus.br/api/v1/comunicacao", {
      params: {
        numeroProcesso: numero,
        meio: "D"
      },
      headers: {
        accept: "application/json"
      }
    });

    res.json(data);
  } catch (error) {
    const status = error.response?.status || 500;
    const mensagem = error.response?.data?.message || "Não foi possível consultar a API externa.";

    res.status(status).json({ erro: mensagem });
  }
});

app.get("*", (_, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.listen(3000, () => {
  console.log("Servidor rodando em http://localhost:3000");
});
