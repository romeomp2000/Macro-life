const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');

const AlimentosPSDSchema = new Schema({
  nombre: {
    type: String,
    required: false,
    trim: true
  },
  calorias: {
    type: Number,
    required: true
  },
  proteina: {
    type: Number,
    required: true
  },
  carbohidratos: {
    type: Number,
    required: true
  },
  grasas: {
    type: Number,
    required: true
  },
  propiedades: {
    type: Map,
    of: String, // El valor de cada propiedad será una cadena (como "30 mg", "10 g")
    default: {} // Inicializamos como un objeto vacío
  }

}, {
  versionKey: false,
  timestamps: true // Añade las fechas de creación y actualización
});

AlimentosPSDSchema.index({ nombre: 1 });

AlimentosPSDSchema.plugin(mongoosePaginate);
module.exports = model('alimentosPSD', AlimentosPSDSchema);
