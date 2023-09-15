-- Creación del esquema: kpCars


create schema if not exists kpcars;


-- Creación de tablas


-- Tabla Group
create table kpcars.car_group (
	id_group SERIAL primary key ,
	group_name varchar(75) not null
);

-- Tabla Brand
create table kpcars.brand (
	id_brand SERIAL primary key,
    brand_name varchar(45) not null,
    id_group int references kpcars.car_group(id_group)
);

-- Tabla Model
create table kpcars.model (
	id_model SERIAL primary key,
    model_name varchar(45) not null,
    id_brand int references kpcars.brand(id_brand)
);

-- Tabla Colour
create table kpcars.colour (
	id_colour SERIAL primary key,
	colour_name VARCHAR(30) not null
);

-- Tabla Insurance Company
create table kpcars.insurance_company (
	id_insurance SERIAL primary key,
	insurance_company VARCHAR(35) not null
);


-- Tabla Coche
create table kpcars.car (
	id_car SERIAL primary key,
    id_model int references kpcars.model(id_model),
    id_colour int references kpcars.colour(id_colour),
    plate varchar(15) not null,
    total_km int,
    id_insurance int references kpcars.insurance_company(id_insurance),
    policy_number varchar(25),
    purchase_date date not null
);

-- Tabla Car Service
create table kpcars.car_service (
    id_service SERIAL primary key,
    id_car int references kpcars.car(id_car),
    km_service int,
    service_date date,
    service_import float,
    currency varchar(15)
);


-- Inserción de registros manuales


-- Insertar registros en la tabla car_group
INSERT INTO kpcars.car_group (group_name) VALUES
	('Renault-Nissan-Mitsubishi Alliance'), 
    ('PSA Peugeot S.A.'), 
    ('Hyundai Motor Group'), 
    ('General Motors'), 
    ('BMW Group');

-- Insertar registros en la tabla brand
INSERT INTO kpcars.brand (brand_name, id_group) VALUES
	('Alfa Romeo', 1), 
    ('Lexus', 2), 
    ('Subaru', 3), 
    ('Maserati', 4), 
    ('Volvo', 5),
	('Porsche', 1), 
    ('Jaguar', 2), 
    ('Land Rover', 3), 
    ('Infiniti', 4), 
    ('Acura', 5);

-- Insertar registros en la tabla insurance_company
INSERT INTO kpcars.insurance_company (insurance_company) VALUES
	('Línea Directa'), 
    ('Mapfre'), 
    ('Seguros Falabella'), 
    ('Mutua Madrileña'),
	('Pacifico Seguros'), 
    ('Allianz'), 
    ('Axa'), 
    ('Seguros Azteca'), 
    ('Generali'), 
    ('Seguros Monterrey');

-- Insertar registros en la tabla model
INSERT INTO kpcars.model (model_name, id_brand) VALUES
	('Giulia', 1), 
    ('NX', 2), 
    ('Impreza', 3), 
    ('Levante', 4), 
    ('XC90', 5),
	('911', 6), 
    ('F-Type', 7), 
    ('Defender', 8), 
    ('QX80', 9), 
    ('MDX', 10);

-- Insertar registros en la tabla colour
INSERT INTO kpcars.colour (colour_name) VALUES
	('Azul'), 
    ('Turquesa'), 
    ('Esmeralda'), 
    ('Rosa'), 
    ('Negro'),
	('Marrón'), 
    ('Bronce'), 
    ('Verde'), 
    ('Cromo'), 
    ('Lila');

-- Insertar registros en la tabla car
INSERT INTO kpcars.car (id_model, id_colour, id_insurance, plate, purchase_date, total_km, policy_number) VALUES  
	(1, 10, 1, '1234 ABC', '2016-08-03', 80000, 'A12345'),
	(2, 9, 2, '5678 DEF', '2018-01-20', 60000, 'B67890'),
	(3, 8, 3, '9101 GHI', '2019-05-12', 70000, 'C11223'),
	(4, 7, 4, '1213 JKL', '2020-06-25', 50000, 'D44556'),
	(5, 6, 5, '1415 MNO', '2021-01-15', 30000, 'E77889'),
	(6, 5, 6, '1617 PQR', '2021-08-23', 40000, 'F99001'),
	(7, 4, 7, '1819 STU', '2022-04-05', 20000, 'G22334'),
	(8, 3, 8, '2021 VWX', '2022-09-11', 10000, 'H55667'),
	(9, 2, 9, '2223 YZA', '2023-03-21', 120000, 'I88990'),
	(10, 1, 10, '2425 BCD', '2023-07-02', 50000, 'J33445'),
	(1, 2, 1, '2627 EFG', '2017-02-14', 65000, 'K66778'),
	(2, 3, 2, '2829 HIJ', '2019-11-08', 130000, 'L11223'),
	(3, 4, 3, '3031 KLM', '2020-12-01', 75000, 'M44556'),
	(4, 5, 4, '3233 NOP', '2021-05-09', 27000, 'N77889'),
	(5, 6, 5, '3435 QRS', '2022-01-20', 99000, 'O99001'),
	(6, 7, 6, '3637 TUV', '2022-08-30', 69000, 'P22334'),
	(7, 8, 7, '3839 WXY', '2023-04-11', 42000, 'Q55667'),
	(8, 9, 8, '4041 ZAB', '2023-09-19', 26000, 'R88990'),
	(9, 10, 9, '4243 CDE', '2024-03-25', 100700, 'S33445'),
	(10, 1, 10, '4445 FGH', '2024-07-07', 51000, 'T66778');

SELECT 
    model.model_name AS "Nombre del Modelo",
    brand.brand_name AS "Nombre de la Marca",
    car_group.group_name AS "Nombre del Grupo Empresarial",
    car.purchase_date AS "Fecha de Compra",
    car.plate AS "Matrícula",
    colour.colour_name AS "Nombre del Color",
    car.total_km AS "Total de Kilómetros",
    insurance_company.insurance_company AS "Nombre de la Empresa Aseguradora",
    car.policy_number AS "Número de Póliza"
FROM 
    kpcars.car
JOIN 
    kpcars.model ON car.id_model = model.id_model
JOIN 
    kpcars.brand ON model.id_brand = brand.id_brand
JOIN 
    kpcars.car_group ON brand.id_group = car_group.id_group
JOIN 
    kpcars.colour ON car.id_colour = colour.id_colour
JOIN 
    kpcars.insurance_company ON car.id_insurance = insurance_company.id_insurance
WHERE 
    car.total_km IS NOT NULL;