from abc import ABC, abstractmethod

class Esmalte(ABC):
    @abstractmethod
    def aplicar(self):
        pass

class EsmalteTradicional(Esmalte):
    def aplicar(self):
        return "Aplicando esmalte tradicional. Seca al aire."

class EsmalteSemipermanente(Esmalte):
    def aplicar(self):
        return "Aplicando esmalte semipermanente. Cura con lámpara UV."

class EsmalteFactory:
    @staticmethod
    def crear_esmalte(tipo):
        if tipo == "tradicional":
            return EsmalteTradicional()
        elif tipo == "semipermanente":
            return EsmalteSemipermanente()
        else:
            raise ValueError("Tipo de esmalte no soportado")

esmalte1 = EsmalteFactory.crear_esmalte("tradicional")
esmalte2 = EsmalteFactory.crear_esmalte("semipermanente")

print(esmalte1.aplicar())  # Salida: Aplicando esmalte tradicional. Seca al aire.
print(esmalte2.aplicar())  # Salida: Aplicando esmalte semipermanente. Cura con lámpara UV.
