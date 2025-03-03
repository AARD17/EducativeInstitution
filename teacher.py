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

class ClassSchedule:
    @staticmethod
    def create_class_schedule(group_name, class_name, weekday, start_hour, end_hour):
        validate_time(start_hour)
        validate_time(end_hour)
        
        group = session.query(Group).filter_by(name=group_name).first()
        if not group:
            raise ValueError(f"Group with name '{group_name}' not found")
        
        _class = session.query(Class).filter_by(name=class_name).first()
        if not _class:
            raise ValueError(f"Class with name '{class_name}' not found")
        
        new_schedule = ClassSchedule(
            group_id=group.id,
            class_id=_class.id,
            weekday=weekday,
            start_hour=start_hour,
            end_hour=end_hour
        )
        
        session.add(new_schedule)
        session.commit()
        return new_schedule

class ScheduleControl:
    @staticmethod
    def addclassschedule(group_name, class_name, start_hour, end_hour):
        weekdays = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
        for day in weekdays:
            schedule = ClassSchedule.create_class_schedule(
                group_name=group_name,
                class_name=class_name,
                weekday=day,
                start_hour=start_hour,
                end_hour=end_hour
            )
            print(f"ClassSchedule added: {schedule.weekday}, {schedule.start_hour} - {schedule.end_hour}")

ScheduleControl.addclassschedule(
    group_name="Group A",
    class_name="Introduction to Programming",
    start_hour="09:00:00",
    end_hour="10:30:00"
)