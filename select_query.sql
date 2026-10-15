USE QuanLySinhVien;

-- 1. Hien thi tat ca hoc vien
SELECT * FROM Student;

-- 2. Hoc vien dang theo hoc
SELECT * FROM Student WHERE Status = TRUE;

-- 3. Mon hoc co Credit nho hon 10
SELECT * FROM Subject WHERE Credit < 10;

-- 4. Hoc vien lop A1
SELECT S.StudentId, S.StudentName, C.ClassName
FROM Student AS S
JOIN Class AS C ON S.ClassId = C.ClassID
WHERE C.ClassName = 'A1';

-- 5. Diem mon CF
SELECT S.StudentId, S.StudentName, Sub.SubName, M.Mark
FROM Student AS S
JOIN Mark AS M ON S.StudentId = M.StudentId
JOIN Subject AS Sub ON M.SubId = Sub.SubId
WHERE Sub.SubName = 'CF';
