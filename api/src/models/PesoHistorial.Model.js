const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');

const PesoHistorialSschema = new Schema({
  usuario: {
    type: Schema.Types.ObjectId,
    ref: 'usuarios',
    required: true
  },
  peso: {
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


PesoHistorialSschema.plugin(mongoosePaginate);
module.exports = model('pesoHistorial', PesoHistorialSschema);
