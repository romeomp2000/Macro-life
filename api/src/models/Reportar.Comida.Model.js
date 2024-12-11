const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');

const reportarComidaSchema = new Schema({
  usuario: {
    type: Schema.Types.ObjectId,
    ref: 'usuarios',
    required: true
  },
  reporte: {
    type: String,
    required: false,
    trim: true
  },
  alimento: {
    type: Schema.Types.ObjectId,
    ref: 'alimentos',
    required: true
  }
}, {
  versionKey: false,
  timestamps: true // Añade las fechas de creación y actualización
});

reportarComidaSchema.plugin(mongoosePaginate);
module.exports = model('reportarComida', reportarComidaSchema);
