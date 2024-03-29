-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT `students`.`name`, `students`.`surname`, `degrees`.`name` AS `degree_name`
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = 'Corso di Laurea in Economia';


-- 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT `degrees`.`name` AS 'degree_name', `departments`.`name` AS 'department_name'
FROM `degrees`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Neuroscienze';

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT `courses`.`name` AS 'course_name', `teachers`.`name` AS 'teacher_name', `teachers`.`surname` AS 'teacher_surname'
FROM `courses`
JOIN `course_teacher`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teachers`.`id` = 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`surname` AS 'student_surname', `students`.`name` AS 'student_name', `degrees`.`name` AS 'degree_name', `departments`.`name` AS 'department_name'
FROM `students`
JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `students`.`surname`, `students`.`name`;

-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT `degrees`.`name` AS 'degree_name', `courses`.`name` AS 'course_name', `teachers`.`name` AS 'teacher_name', `teachers`.`surname` AS 'teacher_surname'
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
ORDER BY `degrees`.`name`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT `teachers`.`name` AS 'teacher_name', `teachers`.`surname` AS 'teacher_surname', `departments`.`name` AS 'department_name'
FROM `teachers`
JOIN `course_teacher`
ON `teachers`.`id` = `course_teacher`.`teacher_id`
JOIN `courses`
ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `degrees`
ON `degrees`.`id` = `courses`.`degree_id`
JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = 'Dipartimento di Matematica';

-- 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami

SELECT `students`.`surname` AS 'student_surname', `students`.`name` AS 'student_name', `courses`.`name` AS 'exam_name', COUNT(*) AS 'n_attempts', MAX(`exam_student`.`vote`) AS 'max_vote'
FROM `exam_student`
JOIN `exams`
ON `exams`.`id` = `exam_student`.`exam_id`
JOIN `courses`
ON `courses`.`id` = `exams`.`course_id`
JOIN `students`
ON `students`.`id` = `exam_student`.`student_id`
GROUP BY `courses`.`name`, `students`.`surname`, `students`.`name`
HAVING MAX(`exam_student`.`vote`) >= 18
ORDER BY `students`.`surname`, `students`.`name`, `courses`.`name`;