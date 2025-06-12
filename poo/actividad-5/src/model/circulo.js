import { Figura } from './figura.js';

export class Circulo extends Figura {
  constructor(id, x, y, color, radio = 30) {
    super(id, x, y, color);
    this.radio = radio;
  }

  dibujar(ctx) {
    ctx.beginPath();
    ctx.arc(this.x, this.y, this.radio, 0, 2 * Math.PI);
    ctx.fillStyle = this.color;
    ctx.fill();
  }
}
