const readXlsxFile = require('read-excel-file/node');
const AlimentosPSD = require('../models/Alimentos.psd.Model');
const initialSetup = async () => {
  const response = await readXlsxFile('src/food_databse/tablita1 sin nada.xlsx');

  response.forEach(async (element, index) => {
    if (index > 2) {
      const nombre = element[0];
      const proteina = isNaN(element[3]) ? null : Number(element[3]);
      const grasas = isNaN(element[4]) ? null : Number(element[4]);
      const carbohidratos = isNaN(element[5]) ? null : Number(element[5]);
      const calorias = isNaN(element[6]) ? null : Number(element[6]);

      const fibra = element[7];
      const calcio = element[9];
      const hierro = element[10];
      const magnesio = element[11];
      const fosforo = element[12];
      const potasio = element[13];
      const sodio = element[14];
      const zinc = element[15];
      const cobre = element[16];
      const vitaminaA = element[17];
      const vitaminaD = element[21];
      const vitaminaE = element[22];
      const vitaminaV6 = element[28];
      const vitaminaB1 = element[31];
      const vitaminaC = element[32];
      const colesterol = element[33];
      const Acido = element[33];

      const comida = new AlimentosPSD({
        nombre,
        calorias: Number(calorias),
        proteina: Number(proteina),
        carbohidratos: Number(carbohidratos),
        grasas: Number(grasas),
        propiedades: {
          Fibra: fibra,
          Calcio: calcio,
          Hierro: hierro,
          Magnesio: magnesio,
          Fósforo: fosforo,
          Potasio: potasio,
          Sodio: sodio,
          Zinc: zinc,
          Cobre: cobre,
          'Vitamina A': vitaminaA,
          'Vitamina D': vitaminaD,
          'Vitamina E': vitaminaE,
          'Vitamina B6': vitaminaV6,
          'Vitamina B1': vitaminaB1,
          'Vitamina C': vitaminaC,
          Colesterol: colesterol,
          Ácido: Acido
        }
      });

      // if (index === 3) {
      await comida.save();
      console.log(comida);
      // }
    }
  });
};

// initialSetup();
