require('colors');
const mongoose = require('mongoose');

mongoose.set('strictQuery', true);

const connectToMongoDB = async () => {
  try {
    await mongoose.connect('mongodb+srv://psdmacro:yUOOvk835LopGxRc@cluster0.b3xjs.mongodb.net/macrolife_db?retryWrites=true&w=majority&appName=Cluster0', {
      // useNewUrlParser: true,
      // useUnifiedTopology: true,
      serverSelectionTimeoutMS: 5000,
      socketTimeoutMS: 45000,
      enableUtf8Validation: false
    });

    console.log('\nConnected to MongoDB!!!\n'.white.bold);
    // Aquí puedes llamar a verifyUsuarioModel() si es necesario
    // verifyUsuarioModel();
  } catch (err) {
    console.error('\nCould not connect to MongoDB\n'.red, err);
  }
};

connectToMongoDB();
