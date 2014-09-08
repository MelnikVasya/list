SQL task

Given tables:
* tasks (id, name, status, project_id)
* projects (id, name)

Write the queries for:

1.get all statuses, not repeating, alphabetically ordered

`SELECT DISTINCT status FROM tasks ORDER BY status ASC`

2.get the count of all tasks in each project, order by tasks count descending

`SELECT COUNT(*) FROM tasks GROUP BY project_id ORDER BY COUNT(*) DESC`

3.get the count of all tasks in each project, order by projects names

`SELECT projects.name, COUNT(tasks.*)tasks FROM projects, tasks WHERE projects.projects_id = tasks.project_id GROUP BY projects.name ORDER BY projects.name`

4.get the tasks for all projects having the name beginning with “N” letter

`SELECT * FROM tasks WHERE name LIKE 'N%'`

5.get the list of all projects containing the ‘a’ letter in the middle of the name, and show the
tasks count near each project. Mention that there can exist projects without tasks and
tasks with project_id=NULL

`SELECT projects.name, COUNT(tasks.tasks_id) FROM projects, tasks WHERE projects.name LIKE '%a%' AND projects.projects_id = tasks.project_id GROUP BY projects.name`

6.get the list of tasks with duplicate names. Order alphabetically

`SELECT * FROM tasks WHERE name IN (SELECT name FROM tasks GROUP BY name HAVING COUNT(name)>1 ) ORDER BY name ASC`

7.get the list of tasks having several exact matches of both name and status, from the project ‘Garage’. Order by matches count

`SELECT tasks.* FROM tasks, projects WHERE projects.name = "Garage" AND projects.projects_id = tasks.project_id GROUP BY tasks.name HAVING COUNT(tasks.name) > 1 AND COUNT(tasks.status) > 1 ORDER BY COUNT(tasks.name) AND COUNT(tasks.status)`

8.get the list of project names having more than 10 tasks in status ‘completed’. Order by project_id

`SELECT name FROM (SELECT projects.name, count(tasks.*) FROM projects, tasks WHERE tasks.status = 'completed' AND  projects.projects_id = tasks.project_id GROUP BY projects.name) as count WHERE tasks > 10`

