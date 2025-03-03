from abc import ABC, abstractmethod
from models import Student, Teacher

class PlataformaProfesorClase:
    def __init__(self):
        self._estudiantes = []
        
    def agregarestudiante(self, alumno):
        self._estudiantes.append(alumno)
        
    def eliminarestudiante(self,alumno):
        self._estudiantes.remove(alumno)
        
    def notificar(self,mensaje):
        for observador in self._observers:
            observador.recibirmensaje(mensaje)
            
class PlataformaDocentes:
    def __init__(self):
        self._docentes = []
        
    def agregardocente(self, profesor):
        self._estudiantes.append(profesor)
        
    def eliminardocente(self,profesor):
        self._estudiantes.remove(profesor)
        
    def notificar(self,mensaje):
        for profe in self._docentes:
            profe.recibirmensaje(mensaje)
            
class CuentaPlataforma(ABC):
    @abstractmethod
    def recibirmensaje(self, mensaje):
        pass
    
    def welcome(self):
        return "Welcome to the Institutional Platform "
    
class CuentaPlataformaAlumno(CuentaPlataforma):
    def __init__(self, student):
        if isinstance(student, Student):
            self.student = student 
        
    def welcome(self):
        return super().welcome() + self.student.first_name + " " + self.student.lastname
    
    def recibirmensaje(self, mensaje):
        print(f"Estimado alumno {self.student.first_name}, tiene el siguiente mensaje: {mensaje}")
        
plataformagrupo1 = PlataformaProfesorClase()
paco = Student("Datos de paco")
cuentapaco = CuentaPlataformaAlumno(paco)
plataformagrupo1.agregarestudiante(cuentapaco)

plataformagrupo1.notificar("No hay clases")

        
class CuentaPlataformaProfesor(CuentaPlataforma):
    def __init__(self, teacher):
        if isinstance(teacher, Teacher):
            self.teacher = teacher 
        
    def welcome(self):
        return super().welcome() + self.teacher.first_name + " " + self.teacher.lastname
    
    def recibirmensaje(self, mensaje):
        print(f"Estimado docente {self.student.first_name}, tiene el siguiente mensaje: {mensaje}")
        
        
plataformaprofesores = PlataformaDocentes()
Fausto = Teacher("Datos de fausto")
cuentafausto = CuentaPlataformaProfesor(Fausto)
plataformaprofesores.agregardocente(cuentafausto)

plataformaprofesores.notificar("El dia de hoy no habra clases")
