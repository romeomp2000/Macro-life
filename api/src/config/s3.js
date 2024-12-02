const { CreateMultipartUploadCommand, UploadPartCommand, CompleteMultipartUploadCommand, PutObjectCommand, DeleteObjectCommand, GetObjectCommand } = require('@aws-sdk/client-s3');
const { getSignedUrl } = require('@aws-sdk/s3-request-presigner');
const fs = require('fs');
const { v4: uuidv4 } = require('uuid');
const path = require('path');
const { AWS_BUCKET_NAME, AWS_BUCKET_REGION } = require('./index.js');
const client = require('./s3Client.js');
const buildFileUrl = (folder, fileName) => `https://${AWS_BUCKET_NAME}.s3.${AWS_BUCKET_REGION}.amazonaws.com/${folder}/${fileName}`;

const buildFileUri = (path) => `https://${AWS_BUCKET_NAME}.s3.${AWS_BUCKET_REGION}.amazonaws.com/${path}`;

const uploadMultipart = async (file, folder) => {
  if (!file) {
    return null;
  }

  const filePath = file.tempFilePath;
  const fileSize = fs.statSync(filePath).size;
  const uniqueFileName = `${uuidv4()}_${file.name}`;
  const key = path.join(folder, uniqueFileName);

  const createMultipartUpload = new CreateMultipartUploadCommand({
    Bucket: AWS_BUCKET_NAME,
    Key: key
  });

  const multipartUpload = await client.send(createMultipartUpload);
  const uploadId = multipartUpload.UploadId;

  const partSize = 10 * 1024 * 1024; // 10MB part size
  const parts = [];
  let partNumber = 1;
  let uploadedBytes = 0;

  while (uploadedBytes < fileSize) {
    const chunk = fs.createReadStream(filePath, {
      start: uploadedBytes,
      end: Math.min(uploadedBytes + partSize, fileSize) - 1
    });

    const uploadPart = new UploadPartCommand({
      Bucket: AWS_BUCKET_NAME,
      Key: key,
      PartNumber: partNumber,
      UploadId: uploadId,
      Body: chunk
    });

    const uploadedPart = await client.send(uploadPart);
    parts.push({
      ETag: uploadedPart.ETag,
      PartNumber: partNumber
    });

    uploadedBytes += partSize;
    partNumber += 1;
  }

  const completeMultipartUpload = new CompleteMultipartUploadCommand({
    Bucket: AWS_BUCKET_NAME,
    Key: key,
    UploadId: uploadId,
    MultipartUpload: {
      Parts: parts
    }
  });

  await client.send(completeMultipartUpload);

  const fileUrl = buildFileUrl(folder, uniqueFileName);

  return {
    fileUrl,
    fileName: uniqueFileName,
    folder,
    originalName: file.name,
    size: file.size,
    mimetype: file.name.split('.').pop(),
    encoding: file.encoding,
    path: `${folder}/${uniqueFileName}`
  };
};

const uploadFile = async (file, folder) => {
  if (!file) {
    return null;
  }

  // Validar que el mimetype esté definido antes de proceder
  if (!file.mimetype) {
    console.error('File mimetype is not defined for file:', file);
    throw new Error('File mimetype is not defined');
  }

  try {
    const filePath = file.tempFilePath;

    if (file.size > 100 * 1024 * 1024) { // Check if file is larger than 100MB
      return await uploadMultipart(file, folder);
    }
    const body = fs.createReadStream(filePath);

    const uniqueFileName = `${uuidv4()}_${file.name.replace(/ /g, '_')}`;
    const uploadParams = {
      Bucket: AWS_BUCKET_NAME,
      Key: path.join(folder, uniqueFileName),
      Body: body
    };

    await client.send(new PutObjectCommand(uploadParams));
    const fileUrl = buildFileUrl(folder, uniqueFileName);

    return {
      fileUrl,
      fileName: uniqueFileName,
      folder,
      originalName: file.name,
      size: file.size,
      mimetype: file.name.split('.').pop(),
      encoding: file.encoding,
      path: `${folder}/${uniqueFileName}`
    };
  } catch (error) {
    console.error('Error uploading file:', error);
    throw new Error('Error uploading file');
  }
};

const deleteFileS3 = async (filePath) => {
  const params = {
    Bucket: AWS_BUCKET_NAME,
    Key: filePath

  };

  try {
    await client.send(new DeleteObjectCommand(params));
    // console.log('Archivo eliminado exitosamente', data);
  } catch (err) {
    console.error('Error al eliminar el archivo', err);
  }
};

const uploadFileFromBuffer = async (buffer, folder) => {
  if (!buffer) {
    return null;
  }

  try {
    const uniqueFileName = `${uuidv4().split('-')[0]}.pdf`;
    const uploadParams = {
      Bucket: AWS_BUCKET_NAME,
      Key: path.join(folder, uniqueFileName),
      Body: buffer
    };

    // Subir el archivo a S3
    await client.send(new PutObjectCommand(uploadParams));

    // Construir la URL del archivo subido
    const fileUrl = buildFileUrl(folder, uniqueFileName);

    // Devolver la información del archivo subido
    return {
      fileUrl,
      fileName: uniqueFileName,
      folder,
      originalName: uniqueFileName,
      size: buffer.length,
      mimetype: uniqueFileName.split('.').pop(),
      path: `${folder}/${uniqueFileName}`
    };
  } catch (error) {
    console.error('Error uploading file from buffer:', error);
    throw new Error('Error uploading file from buffer');
  }
};

const obtenerURL = async ({ key, nuevoNombre = null, expiresIn = 604800 }) => {
  if (!key) {
    throw new Error("El valor de 'key' es requerido.");
  }

  const params = {
    Bucket: process.env.AWS_BUCKET_NAME,
    Key: key
  };

  // Solo agrega el nombre si 'nuevoNombre' no es null
  if (nuevoNombre) {
    params.ResponseContentDisposition = `attachment; filename="${nuevoNombre}"`;
  }

  const command = new GetObjectCommand(params);

  try {
    // Usa la instancia única del cliente para obtener la URL pre-firmada
    const signedUrl = await getSignedUrl(client, command, { expiresIn });
    return signedUrl;
  } catch (error) {
    console.error('Error al obtener la URL pre-firmada:', error);
    throw error;
  }
};

module.exports = {
  uploadFile,
  uploadMultipart,
  deleteFileS3,
  buildFileUri,
  obtenerURL,
  uploadFileFromBuffer
};
