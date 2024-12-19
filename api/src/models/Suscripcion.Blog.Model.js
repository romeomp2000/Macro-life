const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');

const SuscripcionSchema = new Schema({
  correo: {
    type: String,
    trim: true,
    require: false
  },
  telefono: {
    type: String,
    trim: true,
    require: false
  },
  estatus: {
    type: String,
    enum: ['Activo', 'Inactivo'],
    default: 'Activo'
  }
}, {
  versionKey: false,
  timestamps: true
});

SuscripcionSchema.plugin(mongoosePaginate);
module.exports = model('suscripcionBlog', SuscripcionSchema);
