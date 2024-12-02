// Función para encriptar
const encriptar = (cadenaAConvertir) => {
  // Arreglos de caracteres válidos
  const cadena =
    'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,Ñ,ñ,\\,$,.,?,=,!,:,/,_,+,*';
  const cadenaEnc =
    '9z,1y,8x,2w,7v,3u,6t,4s,5r,0q,9P,1O,8N,2M,7A,3B,6C,4D,5E,0F,aZ,bY,cX,dW,eV,gt,Sh,Ri,Qj,Pk,Ol,Nm,Mn,Ao,Bp,Cq,Dr,Es,Ft,Gu,Hv,Iw,Jx,Ky,Lz,1Z,0Q,2Y,9R,3X,8S,4W,zw,ys,xx,wr,vy,uq,tz,sz,ry,qx,Wz,Sy,3w,7Q,s6,T9,Un,Ls,3D,w3,u0,pW,R1';

  const arregloCaracteres = cadena.split(',');
  const arregloModificador = cadenaEnc.split(',');

  let cadenaNueva = '';
  for (const letra of cadenaAConvertir) {
    let contador = 0;
    for (const letraArreglo of arregloCaracteres) {
      if (letra === letraArreglo) {
        const letraEquivalente = arregloModificador[contador];
        cadenaNueva += letraEquivalente;
      }
      contador++;
    }
  }

  // Repetimos la mezcla de caracteres
  const caracteres2 = cadenaNueva.split('');
  let cadenaNueva2 = '';
  for (const letra of caracteres2) {
    let contador = 0;
    for (const letraArreglo of arregloCaracteres) {
      if (letra === letraArreglo) {
        const letraEquivalente = arregloModificador[contador];
        cadenaNueva2 += letraEquivalente;
      }
      contador++;
    }
  }

  const cadenaFinal = Buffer.from(cadenaNueva2).toString('base64');
  return cadenaFinal;
};

// Función para decencriptar
const desencriptar = (cadenaAConvertir) => {
  // Arreglos de caracteres válidos
  const cadena =
    'a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,1,2,3,4,5,6,7,8,9,0,Ñ,ñ,\\,$,.,?,=,!,:,/,_,+,*';
  const cadenaEnc =
    '9z,1y,8x,2w,7v,3u,6t,4s,5r,0q,9P,1O,8N,2M,7A,3B,6C,4D,5E,0F,aZ,bY,cX,dW,eV,gt,Sh,Ri,Qj,Pk,Ol,Nm,Mn,Ao,Bp,Cq,Dr,Es,Ft,Gu,Hv,Iw,Jx,Ky,Lz,1Z,0Q,2Y,9R,3X,8S,4W,zw,ys,xx,wr,vy,uq,tz,sz,ry,qx,Wz,Sy,3w,7Q,s6,T9,Un,Ls,3D,w3,u0,pW,R1';

  const arregloCaracteres = cadena.split(',');
  const arregloModificador = cadenaEnc.split(',');

  const cadenaDecodificada = Buffer.from(cadenaAConvertir, 'base64').toString(
    'utf-8'
  );

  const caracteres = cadenaDecodificada.match(/.{1,2}/g);
  let cadenaNueva = '';
  for (const letra of caracteres) {
    let contador = 0;
    for (const letraArreglo of arregloModificador) {
      if (letra === letraArreglo) {
        const letraEquivalente = arregloCaracteres[contador];
        cadenaNueva += letraEquivalente;
      }
      contador++;
    }
  }

  // Repetimos mezcla de caracteres
  const caracteres2 = cadenaNueva.match(/.{1,2}/g);
  let cadenaNueva2 = '';
  for (const letra of caracteres2) {
    let contador = 0;
    for (const letraArreglo of arregloModificador) {
      if (letra === letraArreglo) {
        const letraEquivalente = arregloCaracteres[contador];
        cadenaNueva2 += letraEquivalente;
      }
      contador++;
    }
  }
  return cadenaNueva2;
};

const formatDate = (date) => {
  const moment = require('moment');
  if (!date) {
    console.log('No date provided');
    return '';
  }

  // Usa moment para convertir y formatear la fecha
  const dateObj = moment(date, 'DD/MM/YYYY, hh:mm A').toDate();

  if (isNaN(dateObj.getTime())) {
    console.log('Invalid date:', date);
    return 'Fecha inválida';
  }

  return new Intl.DateTimeFormat('es-ES', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit'
  }).format(dateObj);
};

const formatDateTime = (date) => {
  if (!date) {
    return null;
  }

  const options = {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    hourCycle: 'h12'
  };

  const formattedDate = new Intl.DateTimeFormat('es-ES', options).format(
    new Date(date)
  );

  // Convertir "a. m." y "p. m." a "AM" y "PM" eliminando espacios no divisibles
  return formattedDate
    .replace(' a. m.', ' AM')
    .replace(' p. m.', ' PM')
    .replace(' a. m.', ' AM')
    .replace(' p. m.', ' PM');
};

const formaTime = (date) => {
  if (!date) {
    return null;
  }

  const options = {
    hour: '2-digit',
    minute: '2-digit',
    hourCycle: 'h12'
  };

  const formattedDate = new Intl.DateTimeFormat('es-ES', options).format(
    new Date(date)
  );

  // Convertir "a. m." y "p. m." a "AM" y "PM" eliminando espacios no divisibles
  return formattedDate.replace(' a. m.', ' AM').replace(' p. m.', ' PM');
};

module.exports = {
  encriptar,
  desencriptar,
  formatDate,
  formatDateTime,
  formaTime
};
