import { Figura } from './figura.js';

export class Triangulo extends Figura {
  constructor(id, x, y, color, base = 60, altura = 50) {
    super(id, x, y, color);
    this.base = base;
    this.altura = altura;
  }

  dibujar(ctx) {
    ctx.fillStyle = this.color;
    ctx.beginPath();
    ctx.moveTo(this.x, this.y);
    ctx.lineTo(this.x + this.base / 2, this.y + this.altura);
    ctx.lineTo(this.x - this.base / 2, this.y + this.altura);
    ctx.closePath();
    ctx.fill();
  }
}
