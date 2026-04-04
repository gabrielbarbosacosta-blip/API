# Consulta de Processo (PJe)

Aplicação web simples para consultar a API pública de comunicações do PJe com base no número do processo.

## Requisitos

- Node.js 18+

## Como executar

```bash
npm install
npm start
```

Abra `http://localhost:3000` no navegador.

## Endpoint backend

- `GET /processo/:numero`

Esse endpoint faz proxy para:
- `https://comunicaapi.pje.jus.br/api/v1/comunicacao`
- Parâmetros: `numeroProcesso` e `meio=D`
