--classroom_settings table
create table if not exists classroom_settings(
  class_name text primary key,
  code text not null,
  daily_limit int not null default 10,
  is_open boolean not null default false
);

--roll mapping table
create table if not exists roll_map(
  class_name text references classroom_settings(class_name) on delete cascade,
  roll_number integer not null,
  name text not null,
  primary key(class_name, roll_number)
);

--attendance table
create table if not exists attendance(
  class_name text references classroom_settings(class_name) on delete cascade,
  roll_number text not null,
  name text not null,
  date date not null,
  time text, --optional, to record exact time
  primary key(class_name, roll_number,date)
);

================================================
--setup CRUD operations

--Allow SELECT
CREATE POLICY "Allow read access"
ON attendance
FOR SELECT
USING (true);

--Allow INSERT
CREATE POLICY "Allow insert access"
ON attendance
FOR INSERT
WITH CHECK (true);

--Allow INSERT
CREATE POLICY "Allow update access"
ON attendance
FOR UPDATE
USING (true)
WITH CHECK (true);

--Allow DELETE
CREATE POLICY "Allow delete access"
ON attendance
FOR DELETE
USING (true); 

CREATE POLICY "Allow read acccess"
ON classroom_settings
FOR SELECT
USING (true);

CREATE POLICY "Allow insert acccess"
ON classroom_settings
FOR INSERT
WITH CHECK (true);

CREATE POLICY "Allow update acccess"
ON classroom_settings
FOR UPDATE
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow delete acccess"
ON classroom_settings
FOR DELETE
USING (true);

CREATE POLICY "Allow read acccess"
ON roll_map
FOR SELECT
USING (true);

CREATE POLICY "Allow insert acccess"
ON roll_map
FOR INSERT
WITH CHECK (true);

CREATE POLICY "Allow update acccess"
ON roll_map
FOR UPDATE
USING (true)
WITH CHECK (true);

CREATE POLICY "Allow delete acccess"
ON roll_map
FOR DELETE
USING (true);

============================================
--Drop table
create or replace function drop_attendance_table(table_name text)
returns void as $$
begin
  execute format('drop table if exists %I;',table_name);
end;
$$ language plpgsql;
==========================