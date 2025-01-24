const { Schema, model } = require("mongoose");
const mongoosePaginate = require("mongoose-paginate-v2");
const VentasSchema = new Schema(
  {
    usuario: {
      type: Schema.Types.ObjectId,
      ref: "usuarios",
      required: true,
    },
    total: {
      type: Number,
      required: false,
      default: false,
    },
    producto: {
      // nombre del producto
      type: String,
      required: true,
    },
    identificador: {
      // ide retornado
      type: String,
      required: true,
    },
    metodoPago: {
      // como fue el pago
      type: String,
      enum: ["PayPal", "Stripe", "Apple Pay", "Google Play", "FREE"],
      required: true,
    },
    fecha: {
      type: Date,
      required: true,
      default: Date.now,
    },
    estado: {
      type: String,
      enum: ["Completado", "Completado", "Cancelado"],
      default: "Completado",
    },
  },
  {
    versionKey: false,
    timestamps: true, // Añade las fechas de creación y actualización
  }
);

VentasSchema.index({ usuario: 1, createdAt: -1 }); // Índice compuesto
VentasSchema.index({ usuario: 1, createdAt: -1 });

VentasSchema.plugin(mongoosePaginate);
module.exports = model("ventas", VentasSchema);
