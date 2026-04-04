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
    const status = error.response?.status || 500;
    const detalhes = error.response?.data || null;

    console.error("Erro ao buscar dados da API PJe:", error.message);
    if (detalhes) {
      console.error("Detalhes da resposta externa:", JSON.stringify(detalhes));
    }

    res.status(status).json({
      erro: "Erro ao buscar dados",
      mensagem:
        detalhes?.message ||
        detalhes?.erro ||
        error.message ||
        "Falha ao consultar a API externa",
      statusExterno: error.response?.status || null,
      detalhes
    });
  }
});

app.get("*", (_, res) => {
  res.sendFile(path.join(__dirname, "public", "index.html"));
});

app.listen(3000, () => {
  console.log("Servidor rodando em http://localhost:3000");
});
