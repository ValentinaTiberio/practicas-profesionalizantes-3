import { Figura } from './figura.js';

export class Rectangulo extends Figura {
  constructor(id, x, y, color, ancho = 80, alto = 40) {
    super(id, x, y, color);
    this.ancho = ancho;
    this.alto = alto;
  }

  dibujar(ctx) {
    ctx.fillStyle = this.color;
    ctx.fillRect(this.x, this.y, this.ancho, this.alto);
  }
}
