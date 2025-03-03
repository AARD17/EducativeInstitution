from sqlalchemy import create_engine
from sqlalchemy.orm import declarative_base, sessionmaker
from datetime import datetime
from abc import ABC, abstractmethod
from validators import validate_date, validate_time, assign_register
from models import *

#---------- CONEXION CON LA BASE DE DATOS, UTILIZANDO SINGLETON PARA ASEGURAR QUE SOLO SE UTILICE 1 VEZ
class DatabaseSingleton:
    _instance = None
    _session = None
    
    def __new__(cls):
        if cls._instance is None:
            cls._instance = super(DatabaseSingleton, cls).__new__(cls)
            cls._instance._initialize()
        return cls._instance
    
    def _initialize(self):
        DATABASE_URL = 'postgresql://postgres:koch123@localhost/Educational'
        engine = create_engine(DATABASE_URL)
        Session = sessionmaker(bind=engine)
        self._session = Session()
    
    @property
    def session(self):
        return self._session
    
    def __del__(self):
        if self._session:
            self._session.close()

db = DatabaseSingleton()
session = db.session


#-----------CREAR UNA CARRERA A PARTIR DE LA CLASE CARRERA CON NOMBRE
class CreateCareer:
    def create_career(self,name, start_date):
        if not validate_date(start_date):
            raise ValueError(f"Invalid date: {start_date}")
        
        new_career = Career(
            name=name,
            start_date=start_date,
            active=True
        )
        
        session.add(new_career)
        session.commit()
        return True
    
#CreateCareer().create_career("Computer Science","2020-01-01")
#----- UTILIZAR BUILDER PARA LOS GRUPOS, ASI PODEMOS HACER DISTINTAS COMBINACIONES DE GRUPOS, POR EL SEMESTRE Y LA CARRERA
class GroupBuilder:
    def add_group_to_db(self, group):
        session.add(group)
        session.commit()
        return group

class GroupManager:
    def __init__(self, builder):
        self.group = Group()
        self.builder = builder

    def set_semester(self, semester):
        self.group.semester = semester
        return self

    def set_career_by_name(self, career_name):
        career = session.query(Career).filter_by(name=career_name).first()
        if career:
            self.group.career_id = career.id
        else:
            raise ValueError(f"Career with name '{career_name}' not found")
        return self

    def build(self):
        return self.builder.add_group_to_db(self.group)

builder = GroupBuilder()
manager = GroupManager(builder)
#group = manager.set_semester('1').set_career_by_name("Computer Science").build()


#----------- UTILIZO FACTORY PARA CREAR ALUMNOS, DE ESTA MANERA SE PUEDEN ASIGNAR LOS 
#----------- ALUMNOS DE CADA SEMESTRE FACILMENTE, DEPENDIENDO DE CUANDO SE INGRESARON
#----------- SERAN SEMESTRE A o SEMESTRE B

class BaseCrearAlumno(ABC):
    @abstractmethod
    #NO SE DEFINE AL SER ABSTRACTO
    def subiralumno(self):
        pass
    

class CrearAlumnoSemestreA(BaseCrearAlumno):
    def subiralumno(self,first_name, last_name, birth_date, phone, career_name,group_id):
        validate_date(birth_date)
        career = session.query(Career).filter_by(name=career_name).first()
        if not career:
            raise ValueError(f"Career with name '{career_name}' not found")

        new_student = Student(
            register="25A" + "0001",
            first_name=first_name,
            last_name=last_name,
            birth_date=birth_date,
            phone=phone,
            career_id=career.id,
            state="Regular",
            group=group_id
        )
        session.add(new_student)
        session.commit()
        return new_student

class CrearAlumnoSemestreB(BaseCrearAlumno):
    def subiralumno(self,first_name, last_name, birth_date, phone, career_name,group_id):
        validate_date(birth_date)
        career = session.query(Career).filter_by(name=career_name).first()
        if not career:
            raise ValueError(f"Career with name '{career_name}' not found")

        new_student = Student(
            register="25B" + "0001",
            first_name=first_name,
            last_name=last_name,
            birth_date=birth_date,
            phone=phone,
            career_id=career.id,
            state="Regular",
            group = group_id
        )
        session.add(new_student)
        session.commit()
        return new_student

class CrearAlumno():
    #ESTATICO NO REQUIERE INSTANCIA
    @staticmethod
    def crearysubiralumno(first_name, last_name, birth_date, phone, career_name):
        registro = assign_register()
        if registro is True:
            newstudent = CrearAlumnoSemestreA()
            newstudent.subiralumno(first_name, last_name, birth_date, phone, career_name)
        elif registro is False:
            newstudent = CrearAlumnoSemestreB()
            newstudent.subiralumno(first_name, last_name, birth_date, phone, career_name)
        else:
            print("Error: Couldn't create new Student")
            
#crearalumnos = CrearAlumno()
#crearalumnos.crearysubiralumno("Angel","Reynoso","2006-05-05","3322112233", "Computer Science")
#print("THE STUDENT WAS SUCCESSFULLY SAVED IN THE DATABASE")

#---------------CREAR UN PROFESOR EN BASE A LA CLASE PROFESORES DE LA BASE DE DATOS


def create_teacher(first_name, last_name, entry_date, address, career_name):
    validate_date(entry_date)
    
    career = session.query(Career).filter_by(name=career_name).first()
    if not career:
        raise ValueError(f"Career with name '{career_name}' not found")
    
    new_teacher = Teacher(
        first_name=first_name,
        last_name=last_name,
        entry_date=entry_date,
        address=address,
        active_=True,
        career_id=career.id
    )
    
    session.add(new_teacher)
    session.commit()
    return new_teacher

#create_teacher("Fausto","Hernandez","2025-03-03","Direccion","Computer Science")

def create_class(name, points, career_name, teacher_name):
    career = session.query(Career).filter_by(name=career_name).first()
    if not career:
         raise ValueError(f"Career with name '{career_name}' not found")
    
    teacher = session.query(Teacher).filter_by(first_name=teacher_name.split()[0], last_name=teacher_name.split()[1]).first()
    if not teacher:
        raise ValueError(f"Teacher with name '{teacher_name}' not found")
    
    new_class = Class(
        name=name,
        points=points,
        career_id=career.id,
        teacher_id=teacher.id
    )
    
    session.add(new_class)
    session.commit()
    return new_class

create_class("Data Bases", 10,"Computer Science", "Fausto Hernandez")
