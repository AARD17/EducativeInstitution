# coding: utf-8
from sqlalchemy import Boolean, Column, Date, Enum, ForeignKey, Integer, String, Time, text
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base

Base = declarative_base()
metadata = Base.metadata


class Career(Base):
    __tablename__ = 'careers'

    id = Column(Integer, primary_key=True, server_default=text("nextval('careers_id_seq'::regclass)"))
    name = Column(String(100), nullable=False)
    start_date = Column(Date, nullable=False)
    active = Column(Boolean, nullable=False)


class Group(Base):
    __tablename__ = 'groups'

    id = Column(Integer, primary_key=True, server_default=text("nextval('groups_id_seq'::regclass)"))
    semester = Column(Enum('1', '2', '3', '4', '5', '6', name='Semesters'), nullable=False)
    career_id = Column(ForeignKey('careers.id'))

    career = relationship('Career')


class Teacher(Base):
    __tablename__ = 'teachers'

    id = Column(Integer, primary_key=True, server_default=text("nextval('teachers_id_seq'::regclass)"))
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    entry_date = Column(Date, nullable=False)
    address = Column(String(100), nullable=False)
    active_ = Column('active ', Boolean, nullable=False)
    career_id = Column(ForeignKey('careers.id'))

    career = relationship('Career')


class Class(Base):
    __tablename__ = 'classes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('classes_id_seq'::regclass)"))
    name = Column(String(50), nullable=False)
    points = Column(Integer, nullable=False)
    career_id = Column(ForeignKey('careers.id'), nullable=False)
    teacher_id = Column(ForeignKey('teachers.id'), nullable=False)

    career = relationship('Career')
    teacher = relationship('Teacher')


class Student(Base):
    __tablename__ = 'students'

    id = Column(Integer, primary_key=True, server_default=text("nextval('students_id_seq'::regclass)"))
    register = Column(String(7), nullable=False)
    first_name = Column(String(50), nullable=False)
    last_name = Column(String(50), nullable=False)
    birth_date = Column(Date, nullable=False)
    phone = Column(String(11), nullable=False)
    career_id = Column(ForeignKey('careers.id'), nullable=False)
    state = Column(Enum('Regular', 'Irregular', 'Conditioned', 'Expelled', name='StudentStates'), nullable=False)
    group = Column(ForeignKey('groups.id'))

    career = relationship('Career')
    group1 = relationship('Group')


class ClassSchedule(Base):
    __tablename__ = 'class_schedule'

    id = Column(Integer, primary_key=True, server_default=text("nextval('class_schedule_id_seq'::regclass)"))
    group_id = Column(ForeignKey('groups.id'), nullable=False)
    class_id = Column(ForeignKey('classes.id'), nullable=False)
    weekday = Column(String(10), nullable=False)
    start_hour = Column(Time, nullable=False)
    end_hour = Column(Time, nullable=False)

    _class = relationship('Class')
    group = relationship('Group')


class Grade(Base):
    __tablename__ = 'grades'

    id = Column(Integer, primary_key=True, server_default=text("nextval('grades_id_seq'::regclass)"))
    grade = Column(Integer, nullable=False)
    date = Column(Date, nullable=False)
    class_id = Column(ForeignKey('classes.id'), nullable=False)
    student_id = Column(ForeignKey('students.id'), nullable=False)

    _class = relationship('Class')
    student = relationship('Student')


class GroupsClass(Base):
    __tablename__ = 'groups_classes'

    id = Column(Integer, primary_key=True, server_default=text("nextval('groups_classes_id_seq'::regclass)"))
    groups_id = Column(ForeignKey('groups.id'), nullable=False)
    classes_id = Column(ForeignKey('classes.id'), nullable=False)

    classes = relationship('Class')
    groups = relationship('Group')
