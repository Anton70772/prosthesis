# База данных для клиники протезирования
![img](https://github.com/Anton70772/prosthesis/blob/main/prosthesis.png)
> [!IMPORTANT]
> Как развернуть дамп бд у себя:
* Скачать файл _prothesis.sql_
* Выполнить
* Наполнить данными(см. раздел "Наполнение данными")

# Наполнение данными
## Для таблицы _doctors_
```sql
INSERT INTO doctors (id, fullName, position, work_experience, phone)
VALUES
(1, 'Адамс Юлия Сергеевна', 'Главный хирург-протезист', 15, '+71234567892'),
(2, 'Михайлов Владимир Петрович', 'Врач-хирург', 10, '+71234167892'),
(3, 'Коваленко Олег Васильевич', 'Врач-протезист', 12, '+71294567892'),
('Иванова Анна Николаевна', 'Главный хирург-протезист', 8, '+71234567893'),
('Петрова Елена Дмитриевна', 'Врач-хирург', 6, '+71234567894'),
('Смирнов Сергей Игоревич', 'Главный хирург-протезист', 10, '+71234567895'),
('Козлова Мария Алексеевна', 'Техник-протезист', 7, '+71234567896'),
('Никитина Антонина Владимировна', 'Ассистент хирурга', 9, '+71234567897'),
('Соколов Игорь Александрович', 'Специалист по наноимплантам', 11, '+71234567898'),
('Федорова Татьяна Сергеевна', 'Ассистент хирурга', 13, '+71234567899');
```
