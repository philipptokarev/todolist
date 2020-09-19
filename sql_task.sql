SQL task.
1. Get all statuses, not repeating, alphabetically Ordered

SELECT DISTINCT status FROM tasks ORDER BY status ASC;

2. Get the count of all tasks in each project, Order by tasks count
descending

SELECT projects.name, COUNT(CASE WHEN tasks.project_id = projects.id THEN 1 END) AS count
FROM projects, tasks
GROUP BY projects.name
ORDER BY count DESC;

3. Get the count of all tasks in each project, order by projects
names

SELECT projects.name, COUNT(CASE WHEN tasks.project_id = projects.id THEN 1 END)
FROM projects, tasks
GROUP BY projects.name
ORDER BY projects.name ASC;

4. Get the tasks for all projects having the name beginning with
"N" letter

SELECT tasks.name
FROM tasks, projects
WHERE tasks.project_id = projects.id AND projects.name LIKE 'N%';

5. Get the list of all projects containing the 'a' letter in the middle of
the name, and show the tasks count near each project.
Mention that there can exist projects without tasks and tasks with
project_id = NULL

SELECT projects.name, COUNT(CASE WHEN tasks.project_id = projects.id THEN 1 END)
FROM projects, tasks
WHERE projects.name LIKE '_%a%_'
GROUP BY projects.name
HAVING COUNT(CASE WHEN tasks.project_id = projects.id THEN 1 END) > 0;

6. Get the list of tasks with duplicate names. Order alphabetically

SELECT name
FROM tasks
GROUP BY name
HAVING COUNT(name) > 1
ORDER BY name ASC;

7. Get list of tasks having several exact matches of both name and
status, FROM the project 'Garage'. Order by matches count

SELECT tasks.name, tasks.status, COUNT(tasks.*) AS count
FROM tasks, projects
WHERE tasks.project_id = projects.id AND projects.name = 'Garage'
GROUP BY tasks.name, tasks.status
HAVING COUNT(tasks.*) > 1
ORDER BY count;

8. Get the list of project names having more than 10 tasks in status
'completed'. Order by project_id

SELECT projects.name, COUNT(CASE WHEN tasks.project_id = projects.id AND tasks.status = 'completed' THEN 1 END)
FROM projects, tasks
GROUP BY projects.id, projects.name
HAVING COUNT(CASE WHEN tasks.project_id = projects.id AND tasks.status = 'completed' THEN 1 END) > 10
ORDER BY projects.id;

