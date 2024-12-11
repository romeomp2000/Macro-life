const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');
// const moment = require('moment');
const AlimentoSchema = new Schema({
  usuario: {
    type: Schema.Types.ObjectId,
    ref: 'usuarios',
    required: true
  },
  favorito: {
    type: Boolean,
    required: false,
    default: false
  },
  nombre: {
    type: String,
    required: false,
    trim: true
  },
  foto: {
    type: String,
    required: false
  },
  ingredientes: [
    {
      type: Schema.Types.ObjectId,
      ref: 'ingredientes',
      required: false
    }
  ],
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
  puntuacionSalud: {
    nombre: {
      type: String,
      required: false,
      trim: true
    },
    descripcion: {
      type: String,
      required: false,
      trim: true
    },
    score: {
      type: Number,
      required: false,
      default: 0,
      min: 0,
      max: 10
    },
    caracteristicas: [
      {
        type: String,
        required: false,
        trim: true
      }
    ]

  },
  fecha: { // la fecha que se comió el alimento
    type: Date,
    required: true
  }
}, {
  versionKey: false,
  timestamps: true // Añade las fechas de creación y actualización
});

// AlimentoSchema.methods.toJSON = function () {
//   const obj = this.toObject();

//   if (obj.createdAt) {
//     moment.locale('es'); // Establece el idioma a español
//     obj.fecha = moment(obj.createdAt)?.format('D [de] MMMM') || '';
//   }
//   return obj;
// };

AlimentoSchema.index({ usuario: 1, createdAt: -1 }); // Índice compuesto
AlimentoSchema.index({ usuario: 1, createdAt: -1 });

AlimentoSchema.plugin(mongoosePaginate);
module.exports = model('alimentos', AlimentoSchema);
