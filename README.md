# База данных для клиники протезирования
![img](https://github.com/Anton70772/prosthesis/blob/main/prosthesis.png)
> [!IMPORTANT]
> ## Как развернуть дамп бд у себя:
* Скачать файл _prothesis.sql_
* Выполнить
* Наполнить данными [(см. раздел Наполнение данными)](#наполнение-данными)

## Навигация:
- [Наполнение данными](#наполнение-данными)
- [Типовые запросы](#Проверка-бд-на-работоспособность)

> [!IMPORTANT]
> ## В бд есть 3 роли:
### *Администратор*:

```sql
-- Создание роли Администратор
CREATE ROLE IF NOT EXISTS admin; 

-- Предоставление полных прав администратору на схему housing
GRANT ALL PRIVILEGES ON prothesis.* TO admin;

-- Создание пользователя
CREATE USER IF NOT EXISTS 'admin'@'localhost' IDENTIFIED BY 'theAdmin777';

-- Назначение роли пользователю
GRANT admin TO 'admin'@'localhost';

-- Активация роли для пользователя
SET DEFAULT ROLE admin TO 'admin'@'localhost';

-- Применение изменений прав
FLUSH PRIVILEGES;
```

### *Мед. персонал*:

```sql
-- Создание роли для медицинского персонала
CREATE ROLE IF NOT EXISTS medical_staff; 

-- Присвоение прав
GRANT SELECT, INSERT, UPDATE, DELETE ON prothesis.patients TO medical_staff;
GRANT SELECT, INSERT, UPDATE, DELETE ON prothesis.doctors TO medical_staff;
GRANT SELECT, INSERT, UPDATE, DELETE ON prothesis.services_reports TO medical_staff;
GRANT SELECT, INSERT ON prothesis.orders TO medical_staff;
GRANT SELECT ON prothesis.appointments TO medical_staff;

-- Создание пользователя
CREATE USER IF NOT EXISTS 'medic'@'localhost' IDENTIFIED BY 'theMedic777';

-- Назначение роли пользователю
GRANT medical_staff TO 'medic'@'localhost';
-- Активация роли для пользователя
SET DEFAULT ROLE medical_staff TO 'medic'@'localhost';
-- Применение изменений прав
FLUSH PRIVILEGES;
```

### *Клиент*:

```sql
CREATE ROLE IF NOT EXISTS client;

-- Присвоение прав 
GRANT SELECT, INSERT ON prothesis.appointments TO client;
GRANT SELECT ON prothesis.doctors TO client;
GRANT SELECT ON prothesis.Services TO client;

-- Создание пользователя
CREATE USER IF NOT EXISTS 'client1'@'localhost' IDENTIFIED BY 'theClient777';

-- Назначение роли пользователю
GRANT client TO 'client1'@'localhost';

-- Активация роли для пользователя
SET DEFAULT ROLE client TO 'client1'@'localhost';

-- Применение изменений прав
FLUSH PRIVILEGES;
```

# Наполнение данными
### Для таблицы _doctors_:
```sql
INSERT INTO doctors (id, fullName, position, work_experience, phone) 
VALUES 
(1, 'Адамс Юлия Сергеевна', 'Главный хирург-протезист', '2015-09-21', '+71234567892'),
('Михайлов Владимир Петрович', 'Врач-хирург', '2010-05-18', '+71234167892'),
('Коваленко Олег Васильевич', 'Врач-протезист', '2012-09-15', '+71294567892'),
('Иванова Анна Николаевна', 'Главный хирург-протезист', '2008-04-19', '+71234567893'),
('Петрова Елена Дмитриевна', 'Врач-хирург', '2006-11-27', '+71234567894'),
('Смирнов Сергей Игоревич', 'Главный хирург-протезист', '2010-06-23', '+71234567895'),
('Козлова Мария Алексеевна', 'Техник-протезист', '2007-12-27', '+71234567896'),
('Никитина Антонина Владимировна', 'Ассистент хирурга', '2009-10-11', '+71234567897'),
('Соколов Игорь Александрович', 'Специалист по наноимплантам', '2011-08-29', '+71234567898'),
('Федорова Татьяна Сергеевна', 'Ассистент хирурга', '2014-07-18', '+71234567899');
```

### Для таблицы _services_:
```sql
INSERT INTO services (id, name, description, price, required_documents, doctors_id) 
VALUES 
(1, 'Установка киберпротеза "Синергия" с консультацией врача-протезиста.', 'Сложная операция по установке киберпротеза с последующими консультациями по эксплуатации и реабилитации.', 15000.00, 'Удостоверение личности, медицинская карта', 1),
(2, 'Процедура аугментации глаз "Соколиный Взгляд" с диагностикой и контрольными обследованиями.', 'Процедура аугментации глаз с использованием передовых технологий и контролями для обеспечения оптимального результата.', 20000.00, 'Удостоверение личности, медицинская карта', 3),
(3, 'Наноимплантация мозгового чипа "Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)" с последующим реабилитационным курсом.', 'Хирургическая процедура установки наноимпланта для улучшения социального взаимодействия, с последующим реабилитационным курсом.', 25000.00, 'Удостоверение личности, медицинская карта', 2),
(4, 'Установка кибернетического протеза кисти "Isoiay" с реабилитационными процедурами.', 'Операция по установке кибернетического протеза для восстановления функциональности кисти с последующим реабилитационным курсом.', 12000.00, 'Удостоверение личности, медицинская карта', 4),
(5, 'Аугментация глаз "Кибернетический протез глаза: "Cognitive interface prosthesis system"" с комплексным медицинским обследованием и дополнительными настройками.', 'Услуга по аугментации глаз с использованием передовых технологий и индивидуальным подбором параметров для максимального комфорта.', 18000.00, 'Удостоверение личности, медицинская карта', 5),
('Наноимплантация "Серебряный Орел" с индивидуальной подборкой протеза и послепроцедурным обслуживанием.', 'Хирургическая процедура установки наноимпланта с индивидуальным подбором протеза и дальнейшим техническим обслуживанием.', 22000.00, 'Удостоверение личности, медицинская карта', 6),
('Установка кибернетического мозгового чипа "Neural SubNet Processor" с консультацией врача-хирурга.', 'Хирургическая процедура установки кибернетического мозгового чипа с последующей консультацией врача-хирурга.', 20000.00, 'Удостоверение личности, медицинская карта', 7),
('Аугментация конечности "Титановый Рукав" с индивидуальным планированием и реабилитацией.', 'Комплексная процедура аугментации конечности с индивидуальным планированием и последующей реабилитацией.', 18000.00, 'Удостоверение личности, медицинская карта', 8),
('Наноимплантация спинного мозга "Нейросеть: Интеллектуальная Доска" с комплексным нейрологическим обследованием.', 'Хирургическая процедура установки наноимпланта для улучшения работы спинного мозга с последующим комплексным нейрологическим обследованием.', 25000.00, 'Удостоверение личности, медицинская карта', 9),
('Установка кибернетического протеза сердца "Синтетический Эндокринный Сердечный Агрегат" с последующим мониторингом состояния и дистанционным управлением.', 'Хирургическая процедура установки кибернетического протеза сердца с последующим мониторингом и управлением через сеть.', 30000.00, 'Удостоверение личности, медицинская карта', 10);
```

### Для таблицы _prosthetics_:
```sql
INSERT INTO prosthetics (id, product_name, manufacturer, price, description) 
VALUES 
(1, 'Кибернетический протез глаза: "Cognitive interface prosthesis system"', 'Sarif Industries', 27000.00, 'Аугментация глаз для улучшения зрения и ночного видения.'),
(2, 'Кибернетический мозговой чип: "Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)"', 'Tai Yong Medical', 17000.00, 'Инновационный мозговой чип, способствующий улучшению когнитивных функций и оптимизации работы мозга.'),
(3, 'Кибернетический протез кисти: "Isoiay"', 'VersaLife', 12000.00, 'Протез "Isoiay" обеспечивает точное и естественное движение кисти, позволяя пациенту вернуться к повседневным делам с комфортом и уверенностью.'),
('Аугментированный интеллектуальный нейроинтерфейс: "SmartVision X4"', 'Sarif Industries', 34000.00, 'Расширяет обзор и улучшает понимание окружающего мира.'),
('Кибернетическая кожа: "DermaFlex Mk.IV"', 'Picus Group', 25000.00, 'Предоставляет высокий уровень защиты и улучшает чувствительность кожи.'),
('Нейро-сетевой интерфейс: "NeuralLink Pro"', 'VersaLife', 38000.00, 'Обеспечивает прямое взаимодействие между мозгом и технологическими устройствами.'),
('Кибернетический имплантат ноги: "PowerStride Plus"', 'LIMB International', 29000.00, 'Повышает скорость и маневренность при движении.'),
('Микро-нейроинтерфейс: "NeuroLink Nano"', 'Tai Yong Medical', 41000.00, 'Миниатюрный имплантат, улучшающий память и когнитивные способности.'),
('Бионическая рука: "TitanArm Mk.II"', 'Sarif Industries', 36000.00, 'Обеспечивает силу и гибкость в повседневных задачах и экстремальных условиях.'),
('Кибернетический слуховой аппарат: "AudioEnhance Bionic Ear"', 'Picus Group', 31000.00, 'Улучшает слух и фильтрует внешние звуки для комфортного восприятия окружающего мира.');
```

### Для таблицы _services_reports_:
```sql
INSERT INTO services_reports (date, notes, doctors_id, services_id)
VALUES 
('2024-04-15', 'Операция прошла успешно, пациент себя чувствует хорошо, рекомендован курс реабилитации.', 1, 1),
('2024-05-18', 'Пациенту требуется последующее наблюдение и курс восстановительных мероприятий.', 2, 2),
('2024-06-20', 'Ожидается полное восстановление функций кисти, а так же необходимо пройти курс реабилитации.', 3, 3),
('2024-07-22', 'Процесс адаптации к новым возможностям проходит без осложнений.', 4, 4),
('2024-08-25', 'Пациент замечает улучшения в памяти и внимании после установки интерфейса.', 5, 5),
('2024-09-25', 'Процесс адаптации проходит успешно, все функции работают в норме', 7, 9),
('2024-10-16', 'Пациент четко видит слова на расстоянии более 500 метров, оттаржения не наблюдается', 1, 5),
('2024-11-19', 'Требуется дополнительная исследовательская работа для оптимизации параметров.', 2, 3),
('2024-12-21', 'Наблюдается улучшение функций сердца после процедуры.', 4, 9),
('2024-12-23', 'Наблюдается значительное увеличение мобильности после процедуры.', 1, 8);
```

### Для таблицы _orders_:
```sql
INSERT INTO orders (order_name, price, count, date, status, doctors_id, prosthetics_id)
VALUES
(1, 'Протеза глаза: "Cognitive interface prosthesis system"', 27000.00, 2, '2024-04-15', 'Создан', 1, 1),
(2, 'Установка мозгового чипа: "Computer-Assisted Social Interaction Enchanced (C.A.S.I.E.)"', 17000.00, 1, '2024-04-18', 'В пути', 2, 2),
(3, 'Установка протеза кисти: "Isoiay"', 12000.00, 2, '2024-04-20', 'Создан', 3, 3),
(4, 'Установка аугментированного интеллектуального нейроинтерфейса: "SmartVision X4"', 34000.00, 1, '2024-04-22', 'В пути', 4, 4),
(5, 'Нейро-сетевой интерфейс: "NeuralLink Pro"', 38000.00, 1, '2024-04-25', 'Получен', 5, 5),
('Бионическая рука: "TitanArm Mk.II"', 36000.00, 1, '2024-04-25', 'Создан', 7, 9);
```

### Для таблицы _patients_:
```sql
INSERT INTO patients (id, fullName, birthday, gender, phone, email) 
VALUES 
(1, 'Сидоров Артем Николаевич', '2001-08-15', 'М', '+71234567893', 'artem@yandex.ru'),
(2, 'Петрова Мария Дмитриевна', '1998-03-20', 'Ж', '+71294567893', 'maria@yandex.ru'),
(3, 'Козлов Александр Александрович', '1995-12-28', 'М', '+71231567893', 'alexander@yandex.ru');
```

### Для таблицы _appointments_:
```sql
INSERT INTO appointments (dateTime, room, status, patients_id, doctors_id, services_id)
VALUES
('2024-05-17 10:00:00', 2, 'Прием завершен', 2, 2, 2),
('2024-04-11 11:00:00', 3, 'Запись отменена', 1, 3, 3),
('2024-06-18 12:00:00', 4, 'Запись назначена', 3, 4, 4),
('2024-07-29 13:00:00', 5, 'Прием завершен', 1, 5, 5),
('2024-08-31 14:00:00', 6, 'Запись назначена', 3, 6, 6),
('2024-05-15 15:00:00', 7, 'Запись отменена', 2, 7, 7);
```

> [!WARNING]
> ### Следующие запросы необходимо выполнять только от роли администратора или медперсонала.

## Типовые запросы:
### Запрос на получение списка врачей и услуг, которые они предоставляют:
```sql
SELECT doctors.fullName AS Doctor_Name, services.name AS Service_Name
FROM doctors
JOIN services ON doctors.id = services.doctors_id;
```

### Запрос на получение списка врачей с наибольшим опытом работы и их должностей:
```sql
SELECT fullName AS Doctor_Name, position AS Doctor_Position, work_experience_start_day AS Experience
FROM doctors
ORDER BY work_experience_start_day ASC
LIMIT 5;
```

### Запрос на получение записей с информацией о пациентах и врачах:
```sql
SELECT appointments.id AS Appointment_ID, patients.fullName AS Patient_Name, doctors.fullName AS Doctor_Name
FROM appointments
JOIN patients ON appointments.patients_id = patients.id
JOIN doctors ON appointments.doctors_id = doctors.id;
```

### Запрос на получение средней цены протезов по производителям:
```sql
SELECT prosthetics.manufacturer, AVG(prosthetics.price) AS average_price
FROM prosthetics
GROUP BY prosthetics.manufacturer;
```

### Запрос на получение общей стоимости всех заказов:
```sql
SELECT SUM(orders.price * orders.count) AS Total_Order_Price
FROM orders;
```

## Представление которое отображает данные о проведенных операциях:
```sql
CREATE VIEW view_operations AS

SELECT services_reports.date, 
doctors.fullName AS doctor, 
patients.fullName AS patient, 
services.name AS service, 
services_reports.notes

FROM services_reports

JOIN doctors ON services_reports.doctors_id = doctors.id

JOIN services ON services_reports.services_id = services.id

JOIN patients ON services.id = patients.id
;
```

## Хранимая процедура для добавления нового клиента и проверка к ней:
```sql
DELIMITER $$

CREATE PROCEDURE NewPatient(
    IN p_fullName VARCHAR(255),
    IN p_birthday DATE,
    IN p_gender CHAR(1),
    IN p_phone CHAR(12),
    IN p_email VARCHAR(100)
)
BEGIN
    DECLARE v_patientExists INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        SELECT CONCAT('Error occurred: ', @p1, ': ', @p2);
    END;
    
    START TRANSACTION;
    
    SELECT COUNT(*) INTO v_patientExists 
    FROM Patients 
    WHERE fullName = p_fullName 
    AND birthday = p_birthday 
    AND gender = p_gender 
    AND phone = p_phone 
    AND email = p_email;
    
    IF v_patientExists = 0 THEN
        INSERT INTO Patients (fullName, birthday, gender, phone, email)
        VALUES (p_fullName, p_birthday, p_gender, p_phone, p_email);
        
        COMMIT;
        SELECT 'Клиент успешно добавлен';
    ELSE
        ROLLBACK;
        SELECT 'Клиент уже существует';
    END IF;
END $$

DELIMITER ;
```
### Вызов процедуры:
```sql
call prosthesis.AddNewPatient('Иванов Иван Иванович', '2004-07-19', 'М', '+79308361724', 'ivanov@yandex.ru');
```

## Триггер для хранимой процедуры по добавлению клиента:
```sql 
DELIMITER $$

CREATE TRIGGER DuplicateAppointments
BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN
    DECLARE appointment_count INT;
    
    SELECT COUNT(*) INTO appointment_count
    FROM appointments
    WHERE dateTime = NEW.dateTime
    AND doctors_id = NEW.doctors_id;
    
    IF appointment_count > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Запись уже существует';
    END IF;
END$$

DELIMITER ;
```

## Хранимая процедура для записи на прием и проверка к ней:
```sql 
DELIMITER $$

CREATE PROCEDURE addAppointment(
    IN p_patient_id INT,
    IN p_doctor INT,
    IN p_service INT,
    IN p_date DATETIME,
    IN p_room INT
)
BEGIN
    DECLARE appointment_id INT;
    DECLARE error_message VARCHAR(255) DEFAULT NULL;

    IF EXISTS (
        SELECT * FROM appointments 
        WHERE dateTime = p_date 
        AND doctors_id = p_doctor
    ) THEN
        SET error_message = 'Вы не можете записаться на прием в это время, так как у данного врача уже есть запись.';
    ELSE
        INSERT INTO appointments (dateTime, room, status, patients_id, doctors_id, services_id)
        VALUES (p_date, p_room, 'Запись назначена', p_patient_id, p_doctor, p_service);

        SET appointment_id = LAST_INSERT_ID();
    END IF;

    IF error_message IS NOT NULL THEN
        SELECT error_message AS Message;
    ELSE
        SELECT 'Вы успешно записались на прием' AS Message;
    END IF;
END $$

DELIMITER ;
```

### Вызов процедуры:
```sql 
call prosthesis.addAppointment(3, 1, 3, '2024-04-25 14:10:00', 124);
```

## Функция ,которая считает общее количество приемов для определенного пациента и тестирование к неё:
```sql 
DELIMITER $$

CREATE FUNCTION GetTotalAppointments(patient_id INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total_appointments INT;
    
    SELECT COUNT(*) INTO total_appointments
    FROM appointments
    WHERE patients_id = patient_id;
    
    RETURN total_appointments;
END$$

DELIMITER ;
```

### Вызов функции:
```sql 
select prothesis.GetTotalAppointments(1);
```
