const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');

const IngredientesSchema = new Schema({
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
  porciones: {
    type: Number,
    required: false,
    default: 1
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
  eliminado: {
    type: Boolean,
    required: true,
    default: false
  }
}, {
  versionKey: false,
  timestamps: true // Añade las fechas de creación y actualización
});

IngredientesSchema.plugin(mongoosePaginate);
module.exports = model('ingredientes', IngredientesSchema);
