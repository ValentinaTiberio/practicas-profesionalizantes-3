export class Figura {
  constructor(id, x, y, color) {
    this.id = id;
    this.x = x;
    this.y = y;
    this.color = color;
  }

  mover(dx, dy) {
    this.x += dx;
    this.y += dy;
  }

  cambiarColor(nuevoColor) {
    this.color = nuevoColor;
  }

  dibujar(ctx) {
    throw new Error("Método 'dibujar' no implementado");
  }

  tipo() {
    return this.constructor.name;
  }
}
