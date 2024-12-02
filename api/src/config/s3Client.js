// s3Client.js
const { S3Client } = require('@aws-sdk/client-s3');
const { AWS_BUCKET_REGION, AWS_PUBLIC_KEY, AWS_SECRET_KEY } = require('./index.js'); // Asegúrate de tener las variables correctas de AWS

// Crea una única instancia de S3Client
const client = new S3Client({
  region: AWS_BUCKET_REGION,
  credentials: {
    accessKeyId: AWS_PUBLIC_KEY,
    secretAccessKey: AWS_SECRET_KEY
  },
  maxAttempts: 5 // Puedes ajustar este parámetro si lo necesitas
});

module.exports = client;
