import { Rectangulo } from './rectangulo.js';
import { Circulo } from './circulo.js';
import { Triangulo } from './triangulo.js';

export class FiguraFactory {
  static crearFigura(tipo, id, x, y, color) {
    switch (tipo) {
      case 'rectangulo':
        return new Rectangulo(id, x, y, color);
      case 'circulo':
        return new Circulo(id, x, y, color);
      case 'triangulo':
        return new Triangulo(id, x, y, color);
      default:
        throw new Error("Tipo de figura no válido");
    }
  }
}
