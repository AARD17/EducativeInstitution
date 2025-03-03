PGDMP  ,    5                }            Educational    17.2    17.2 J               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false                       1262    19116    Educational    DATABASE     �   CREATE DATABASE "Educational" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
    DROP DATABASE "Educational";
                     postgres    false            x           1247    19286 	   Semesters    TYPE     a   CREATE TYPE public."Semesters" AS ENUM (
    '1',
    '2',
    '3',
    '4',
    '5',
    '6'
);
    DROP TYPE public."Semesters";
       public               postgres    false            ]           1247    19160    StudentStates    TYPE     r   CREATE TYPE public."StudentStates" AS ENUM (
    'Regular',
    'Irregular',
    'Conditioned',
    'Expelled'
);
 "   DROP TYPE public."StudentStates";
       public               postgres    false            �            1259    19170    careers    TABLE     �   CREATE TABLE public.careers (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    start_date date NOT NULL,
    active boolean NOT NULL
);
    DROP TABLE public.careers;
       public         heap r       postgres    false            �            1259    19169    careers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.careers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.careers_id_seq;
       public               postgres    false    218                       0    0    careers_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.careers_id_seq OWNED BY public.careers.id;
          public               postgres    false    217            �            1259    19177    class_schedule    TABLE       CREATE TABLE public.class_schedule (
    id integer NOT NULL,
    group_id integer NOT NULL,
    class_id integer NOT NULL,
    weekday character varying(10) NOT NULL,
    start_hour time without time zone NOT NULL,
    end_hour time without time zone NOT NULL
);
 "   DROP TABLE public.class_schedule;
       public         heap r       postgres    false            �            1259    19176    class_schedule_id_seq    SEQUENCE     �   CREATE SEQUENCE public.class_schedule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.class_schedule_id_seq;
       public               postgres    false    220                       0    0    class_schedule_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.class_schedule_id_seq OWNED BY public.class_schedule.id;
          public               postgres    false    219            �            1259    19184    classes    TABLE     �   CREATE TABLE public.classes (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    points integer NOT NULL,
    career_id integer NOT NULL,
    teacher_id integer NOT NULL
);
    DROP TABLE public.classes;
       public         heap r       postgres    false            �            1259    19183    classes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.classes_id_seq;
       public               postgres    false    222                       0    0    classes_id_seq    SEQUENCE OWNED BY     A   ALTER SEQUENCE public.classes_id_seq OWNED BY public.classes.id;
          public               postgres    false    221            �            1259    19191    grades    TABLE     �   CREATE TABLE public.grades (
    id integer NOT NULL,
    grade integer NOT NULL,
    date date NOT NULL,
    class_id integer NOT NULL,
    student_id integer NOT NULL
);
    DROP TABLE public.grades;
       public         heap r       postgres    false            �            1259    19190    grades_id_seq    SEQUENCE     �   CREATE SEQUENCE public.grades_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.grades_id_seq;
       public               postgres    false    224                       0    0    grades_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.grades_id_seq OWNED BY public.grades.id;
          public               postgres    false    223            �            1259    19198    groups    TABLE     �   CREATE TABLE public.groups (
    id integer NOT NULL,
    career_id integer NOT NULL,
    semester public."Semesters" NOT NULL
);
    DROP TABLE public.groups;
       public         heap r       postgres    false    888            �            1259    19205    groups_classes    TABLE     �   CREATE TABLE public.groups_classes (
    id integer NOT NULL,
    groups_id integer NOT NULL,
    classes_id integer NOT NULL
);
 "   DROP TABLE public.groups_classes;
       public         heap r       postgres    false            �            1259    19204    groups_classes_id_seq    SEQUENCE     �   CREATE SEQUENCE public.groups_classes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.groups_classes_id_seq;
       public               postgres    false    228                       0    0    groups_classes_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.groups_classes_id_seq OWNED BY public.groups_classes.id;
          public               postgres    false    227            �            1259    19197    groups_id_seq    SEQUENCE     �   CREATE SEQUENCE public.groups_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 $   DROP SEQUENCE public.groups_id_seq;
       public               postgres    false    226                       0    0    groups_id_seq    SEQUENCE OWNED BY     ?   ALTER SEQUENCE public.groups_id_seq OWNED BY public.groups.id;
          public               postgres    false    225            �            1259    19212    students    TABLE     k  CREATE TABLE public.students (
    id integer NOT NULL,
    register character varying(7) NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    birth_date date NOT NULL,
    phone character varying(11) NOT NULL,
    career_id integer NOT NULL,
    state public."StudentStates" NOT NULL,
    "group" integer
);
    DROP TABLE public.students;
       public         heap r       postgres    false    861            �            1259    19211    students_id_seq    SEQUENCE     �   CREATE SEQUENCE public.students_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.students_id_seq;
       public               postgres    false    230                       0    0    students_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.students_id_seq OWNED BY public.students.id;
          public               postgres    false    229            �            1259    19219    teachers    TABLE       CREATE TABLE public.teachers (
    id integer NOT NULL,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL,
    entry_date date NOT NULL,
    address character varying(100) NOT NULL,
    "active " boolean NOT NULL,
    career_id integer
);
    DROP TABLE public.teachers;
       public         heap r       postgres    false            �            1259    19218    teachers_id_seq    SEQUENCE     �   CREATE SEQUENCE public.teachers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.teachers_id_seq;
       public               postgres    false    232                       0    0    teachers_id_seq    SEQUENCE OWNED BY     C   ALTER SEQUENCE public.teachers_id_seq OWNED BY public.teachers.id;
          public               postgres    false    231            J           2604    19173 
   careers id    DEFAULT     h   ALTER TABLE ONLY public.careers ALTER COLUMN id SET DEFAULT nextval('public.careers_id_seq'::regclass);
 9   ALTER TABLE public.careers ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    217    218    218            K           2604    19180    class_schedule id    DEFAULT     v   ALTER TABLE ONLY public.class_schedule ALTER COLUMN id SET DEFAULT nextval('public.class_schedule_id_seq'::regclass);
 @   ALTER TABLE public.class_schedule ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    220    219    220            L           2604    19187 
   classes id    DEFAULT     h   ALTER TABLE ONLY public.classes ALTER COLUMN id SET DEFAULT nextval('public.classes_id_seq'::regclass);
 9   ALTER TABLE public.classes ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    222    221    222            M           2604    19194 	   grades id    DEFAULT     f   ALTER TABLE ONLY public.grades ALTER COLUMN id SET DEFAULT nextval('public.grades_id_seq'::regclass);
 8   ALTER TABLE public.grades ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    223    224    224            N           2604    19201 	   groups id    DEFAULT     f   ALTER TABLE ONLY public.groups ALTER COLUMN id SET DEFAULT nextval('public.groups_id_seq'::regclass);
 8   ALTER TABLE public.groups ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    226    225    226            O           2604    19208    groups_classes id    DEFAULT     v   ALTER TABLE ONLY public.groups_classes ALTER COLUMN id SET DEFAULT nextval('public.groups_classes_id_seq'::regclass);
 @   ALTER TABLE public.groups_classes ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    227    228            P           2604    19215    students id    DEFAULT     j   ALTER TABLE ONLY public.students ALTER COLUMN id SET DEFAULT nextval('public.students_id_seq'::regclass);
 :   ALTER TABLE public.students ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    230    229    230            Q           2604    19222    teachers id    DEFAULT     j   ALTER TABLE ONLY public.teachers ALTER COLUMN id SET DEFAULT nextval('public.teachers_id_seq'::regclass);
 :   ALTER TABLE public.teachers ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    232    232                       0    19170    careers 
   TABLE DATA           ?   COPY public.careers (id, name, start_date, active) FROM stdin;
    public               postgres    false    218   �V                 0    19177    class_schedule 
   TABLE DATA           _   COPY public.class_schedule (id, group_id, class_id, weekday, start_hour, end_hour) FROM stdin;
    public               postgres    false    220   �V                 0    19184    classes 
   TABLE DATA           J   COPY public.classes (id, name, points, career_id, teacher_id) FROM stdin;
    public               postgres    false    222   �V                 0    19191    grades 
   TABLE DATA           G   COPY public.grades (id, grade, date, class_id, student_id) FROM stdin;
    public               postgres    false    224   W                 0    19198    groups 
   TABLE DATA           9   COPY public.groups (id, career_id, semester) FROM stdin;
    public               postgres    false    226   .W       
          0    19205    groups_classes 
   TABLE DATA           C   COPY public.groups_classes (id, groups_id, classes_id) FROM stdin;
    public               postgres    false    228   QW                 0    19212    students 
   TABLE DATA           u   COPY public.students (id, register, first_name, last_name, birth_date, phone, career_id, state, "group") FROM stdin;
    public               postgres    false    230   tW                 0    19219    teachers 
   TABLE DATA           h   COPY public.teachers (id, first_name, last_name, entry_date, address, "active ", career_id) FROM stdin;
    public               postgres    false    232   �W                  0    0    careers_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.careers_id_seq', 1, true);
          public               postgres    false    217                       0    0    class_schedule_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.class_schedule_id_seq', 1, false);
          public               postgres    false    219                       0    0    classes_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.classes_id_seq', 1, true);
          public               postgres    false    221                        0    0    grades_id_seq    SEQUENCE SET     <   SELECT pg_catalog.setval('public.grades_id_seq', 1, false);
          public               postgres    false    223            !           0    0    groups_classes_id_seq    SEQUENCE SET     D   SELECT pg_catalog.setval('public.groups_classes_id_seq', 1, false);
          public               postgres    false    227            "           0    0    groups_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('public.groups_id_seq', 1, true);
          public               postgres    false    225            #           0    0    students_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.students_id_seq', 1, true);
          public               postgres    false    229            $           0    0    teachers_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.teachers_id_seq', 1, true);
          public               postgres    false    231            S           2606    19175    careers careers_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.careers
    ADD CONSTRAINT careers_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.careers DROP CONSTRAINT careers_pkey;
       public                 postgres    false    218            U           2606    19182 "   class_schedule class_schedule_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.class_schedule
    ADD CONSTRAINT class_schedule_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.class_schedule DROP CONSTRAINT class_schedule_pkey;
       public                 postgres    false    220            W           2606    19189    classes classes_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT classes_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.classes DROP CONSTRAINT classes_pkey;
       public                 postgres    false    222            Y           2606    19196    grades grades_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_pkey;
       public                 postgres    false    224            ]           2606    19210 "   groups_classes groups_classes_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.groups_classes
    ADD CONSTRAINT groups_classes_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.groups_classes DROP CONSTRAINT groups_classes_pkey;
       public                 postgres    false    228            [           2606    19203    groups groups_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT groups_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.groups DROP CONSTRAINT groups_pkey;
       public                 postgres    false    226            _           2606    19217    students students_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.students
    ADD CONSTRAINT students_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.students DROP CONSTRAINT students_pkey;
       public                 postgres    false    230            a           2606    19224    teachers teachers_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.teachers DROP CONSTRAINT teachers_pkey;
       public                 postgres    false    232            d           2606    19235    classes class_careers    FK CONSTRAINT     �   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT class_careers FOREIGN KEY (career_id) REFERENCES public.careers(id) NOT VALID;
 ?   ALTER TABLE ONLY public.classes DROP CONSTRAINT class_careers;
       public               postgres    false    218    4691    222            b           2606    19225    class_schedule class_id    FK CONSTRAINT     �   ALTER TABLE ONLY public.class_schedule
    ADD CONSTRAINT class_id FOREIGN KEY (class_id) REFERENCES public.classes(id) NOT VALID;
 A   ALTER TABLE ONLY public.class_schedule DROP CONSTRAINT class_id;
       public               postgres    false    4695    222    220            e           2606    19240    classes class_teachers    FK CONSTRAINT     �   ALTER TABLE ONLY public.classes
    ADD CONSTRAINT class_teachers FOREIGN KEY (teacher_id) REFERENCES public.teachers(id) NOT VALID;
 @   ALTER TABLE ONLY public.classes DROP CONSTRAINT class_teachers;
       public               postgres    false    4705    232    222            i           2606    19260    groups_classes gpclss_classes    FK CONSTRAINT     �   ALTER TABLE ONLY public.groups_classes
    ADD CONSTRAINT gpclss_classes FOREIGN KEY (classes_id) REFERENCES public.classes(id) NOT VALID;
 G   ALTER TABLE ONLY public.groups_classes DROP CONSTRAINT gpclss_classes;
       public               postgres    false    222    228    4695            j           2606    19265    groups_classes gpclss_groups    FK CONSTRAINT     �   ALTER TABLE ONLY public.groups_classes
    ADD CONSTRAINT gpclss_groups FOREIGN KEY (groups_id) REFERENCES public.groups(id) NOT VALID;
 F   ALTER TABLE ONLY public.groups_classes DROP CONSTRAINT gpclss_groups;
       public               postgres    false    226    228    4699            f           2606    19245    grades grade_classes    FK CONSTRAINT     �   ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grade_classes FOREIGN KEY (class_id) REFERENCES public.classes(id) NOT VALID;
 >   ALTER TABLE ONLY public.grades DROP CONSTRAINT grade_classes;
       public               postgres    false    4695    224    222            g           2606    19250    grades grades_students    FK CONSTRAINT     �   ALTER TABLE ONLY public.grades
    ADD CONSTRAINT grades_students FOREIGN KEY (student_id) REFERENCES public.students(id) NOT VALID;
 @   ALTER TABLE ONLY public.grades DROP CONSTRAINT grades_students;
       public               postgres    false    4703    230    224            h           2606    19255    groups group_career    FK CONSTRAINT     �   ALTER TABLE ONLY public.groups
    ADD CONSTRAINT group_career FOREIGN KEY (career_id) REFERENCES public.careers(id) NOT VALID;
 =   ALTER TABLE ONLY public.groups DROP CONSTRAINT group_career;
       public               postgres    false    218    226    4691            c           2606    19230    class_schedule schedule_group    FK CONSTRAINT     �   ALTER TABLE ONLY public.class_schedule
    ADD CONSTRAINT schedule_group FOREIGN KEY (group_id) REFERENCES public.groups(id) NOT VALID;
 G   ALTER TABLE ONLY public.class_schedule DROP CONSTRAINT schedule_group;
       public               postgres    false    220    4699    226            k           2606    19270    students student_careers    FK CONSTRAINT     �   ALTER TABLE ONLY public.students
    ADD CONSTRAINT student_careers FOREIGN KEY (career_id) REFERENCES public.careers(id) NOT VALID;
 B   ALTER TABLE ONLY public.students DROP CONSTRAINT student_careers;
       public               postgres    false    4691    230    218            l           2606    19275    students student_groups    FK CONSTRAINT     �   ALTER TABLE ONLY public.students
    ADD CONSTRAINT student_groups FOREIGN KEY ("group") REFERENCES public.groups(id) NOT VALID;
 A   ALTER TABLE ONLY public.students DROP CONSTRAINT student_groups;
       public               postgres    false    230    4699    226            m           2606    19280    teachers teacher_career    FK CONSTRAINT     �   ALTER TABLE ONLY public.teachers
    ADD CONSTRAINT teacher_career FOREIGN KEY (career_id) REFERENCES public.careers(id) NOT VALID;
 A   ALTER TABLE ONLY public.teachers DROP CONSTRAINT teacher_career;
       public               postgres    false    4691    232    218                +   x�3�t��-(-I-RN�L�KN�4202�50"��=... �r	|            x������ � �         !   x�3�tI,ITpJ,N-�44�4�4����� Q�S            x������ � �            x�3�4�4����� �X      
      x�3�4�4����� �X         E   x�3�42u2000�t�KO��J���/��4200�50"Ncc##CC##ccNC�|ziNbg�W� �D�         7   x�3�tK,-.���H-�K�KI��4202�50"N�̢�����<�NC�=... kI     