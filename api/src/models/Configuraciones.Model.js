const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');
// const moment = require('moment');
const ConfiguracionesSchema = new Schema({
  suscripcion: {
    mensual: {
      type: Number,
      required: false,
      trim: true
    },
    anual: {
      type: Number,
      required: false
    },
    descuentoAnual: {
      type: Number,
      required: false,
      trim: true
    }
  },
  payPal: {
    clientID: {
      type: String,
      required: false
    },
    secretKey: {
      type: String,
      required: false
    }
  },
  stripe: {
    publicKey: {
      type: String,
      required: false
    },
    secretKey: {
      type: String,
      required: false
    }
  }
}, {
  versionKey: false,
  timestamps: true
});

ConfiguracionesSchema.plugin(mongoosePaginate);
module.exports = model('configuraciones', ConfiguracionesSchema);
