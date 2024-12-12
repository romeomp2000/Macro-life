const { Schema, model } = require('mongoose');
const mongoosePaginate = require('mongoose-paginate-v2');
const moment = require('moment'); // Asegúrate de instalar moment.js

const UsuariosSchema = new Schema({
  referenciaUsuario: {
    type: Schema.Types.ObjectId,
    ref: 'usuarios',
    required: false,
    default: null
  },
  fechaVencimiento: { // suscripción
    type: Date,
    required: false,
    default: null
  },
  codigo: { // de invitado
    type: String,
    required: false,
    unique: true
  },
  balance: { // balance de dinero
    type: Number,
    require: false,
    default: 0
  },
  rachaDias: {
    type: Number,
    require: false,
    default: 0
  },
  fechaNacimiento: {
    type: Date,
    required: true
  },
  altura: {
    type: Number,
    require: true
  },
  pesoActual: {
    type: Number,
    require: true
  },
  genero: {
    type: String,
    enum: ['Masculino', 'Femenino', 'Otro'],
    require: true
  },
  puntuacionSalud: {
    type: Number,
    require: true
  },
  macronutrientes: {
    calorias: {
      type: Number,
      require: true,
      default: 0
    },
    proteina: {
      type: Number,
      require: true,
      default: 0

    },
    carbohidratos: {
      type: Number,
      require: true,
      default: 0
    },
    grasas: {
      type: Number,
      require: true,
      default: 0
    }
  },
  macronutrientesDiario: {
    calorias: {
      type: Number,
      require: true
    },
    proteina: {
      type: Number,
      require: true
    },
    carbohidratos: {
      type: Number,
      require: true
    },
    grasas: {
      type: Number,
      require: true
    }
  },
  // mas información
  entrenamientoSemanal: {
    type: String,
    enum: ['0-2', '3-5', '6+'],
    require: false
  },
  aplicacionSimilar: {
    type: String,
    enum: ['No', 'Si'],
    default: 'No',
    require: false
  },
  fechaMeta: { // que día se cumple el objetivp
    type: Date,
    required: false,
    default: null
  },
  objetivo: {
    type: String,
    enum: ['Perder peso', 'Mantener', 'Aumentar peso'],
    require: false
  },
  pesoObjetivo: { // no va ser requerido
    type: Number,
    require: false
  },
  dieta: {
    type: String,
    enum: ['Clásico', 'Pescetariana', 'Vegetariano', 'Vegano'],
    require: false
  },
  lograr: { // que le gustaría lograr
    type: String,
    enum: ['Come y vive más sano', 'Aumentar mi energía y estado de ánimo', 'Manténgase motivado y constante', 'Sentir mejor con mi cuerpo'],
    require: false
  },
  metaAlcanzar: { // que tán rápido quiere alcanza tu meta 0.1 -> 1.5
    type: Number,
    require: false
  },
  impideAlcanzar: { // que te impide a alcanzar tu meta
    type: String,
    enum: ['Falta de constancia', 'Hábitos alimenticios poco saludables', 'Falta de apoyo', 'Agenda ocupada', 'Falta de inspiración para la comida'],
    require: false
  },
  googleId: {
    type: String,
    required: false
  },
  appleID: {
    type: String,
    required: false
  },
  estatus: {
    type: String,
    enum: ['Activo', 'Inactivo'],
    require: false,
    default: 'Activo'
  }

}, { versionKey: false }
);

// Pre-save hook para formatear la fecha antes de guardar

const generarClave = () => {
  return Math.random().toString(36).substring(2, 10).toUpperCase(); // Generar clave aleatoria corta
};

// Pre-save hook to generate distributor key
UsuariosSchema.pre('save', async function (next) {
  if (!this.codigo) {
    try {
      let claveGenerada;
      let esUnica = false;

      while (!esUnica) {
        claveGenerada = generarClave();

        const busca = await usuarioModel.countDocuments({ codigo: claveGenerada });

        if (busca === 0) {
          esUnica = true;
        }
      }

      this.codigo = claveGenerada;
    } catch (error) {
      return next(error);
    }
  }
  next();
});

// Método para formatear fechas y calcular días restantes
UsuariosSchema.methods.toJSON = function () {
  const obj = this.toObject();

  // Formatear fechaVencimiento
  obj.vencido = false;
  if (obj.fechaVencimiento) {
    obj.fechaVencimientoFormato = moment(obj.fechaVencimiento).format('DD/MM/YYYY');
    obj.diasAVencer = moment(obj.fechaVencimiento).diff(moment(), 'days');
    // Bandera para saber si la mensualidad ya venció
    obj.vencido = moment(obj.fechaVencimiento).isBefore(moment()) || true; // Si la fecha de vencimiento es antes de la fecha actual, venció
  }

  // Formatear fechaNacimiento
  if (obj.fechaNacimiento) {
    obj.fechaNacimientoFormato = moment(obj.fechaNacimiento).format('DD/MM/YYYY');
    obj.edad = moment().diff(obj.fechaNacimiento, 'years');
  }

  // Formatear fechaMeta
  if (obj.fechaMeta) {
    moment.locale('es'); // Establece el idioma a español
    obj.fechaMetaObjetivo = moment(obj.fechaMeta)?.format('D [de] MMMM [del] YYYY') || '';
  }

  return obj;
};

UsuariosSchema.plugin(mongoosePaginate);

const usuarioModel = model('usuarios', UsuariosSchema);

module.exports = usuarioModel;
