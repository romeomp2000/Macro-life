const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');

const EjercicioSchema = new Schema({
  usuario: {
    type: Schema.Types.ObjectId,
    ref: 'usuarios',
    required: true
  },
  nombre: {
    type: String,
    required: false,
    trim: true
  },
  ejercicio: {
    type: String,
    enum: ['Ejecutar', 'Levantamiento de pesas', 'Describir'],
    required: false,
    trim: true
  },
  intensidad: {
    type: String,
    enum: ['Ligero', 'Moderado', 'Intenso'],
    required: false
  },
  calorias: {
    type: Number,
    required: true
  },
  tiempo: {
    type: Number,
    required: true
  },
  fecha: {
    type: Date,
    required: true,
    default: Date.now
  }
}, {
  versionKey: false,
  timestamps: true
});

EjercicioSchema.methods.toJSON = function () {
  const obj = this.toObject();

  if (obj.fecha) {
    const moment = require('moment-timezone');
    moment.locale('es');

    obj.time = moment(obj.fecha).tz('America/Mexico_City').format('h:mm a') || '';
  }

  if (obj.calorias) {
    obj.calorias = parseInt(obj.calorias, 10); // Asegura que calorias sea un entero
  }

  return obj;
};

EjercicioSchema.plugin(mongoosePaginate);
module.exports = model('ejercicios', EjercicioSchema);
