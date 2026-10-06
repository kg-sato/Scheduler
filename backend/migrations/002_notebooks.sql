-- Local draft only. Run after 001_scheduler.sql when authenticated sync is implemented.
begin;

create table public.scheduler_courses (
  user_id uuid not null references auth.users(id) on delete cascade,
  name text not null check (length(trim(name)) between 1 and 60),
  notes text not null default '' check (length(notes) <= 5000),
  confidence smallint not null default 3 check (confidence between 1 and 5),
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id, name)
);
create unique index scheduler_course_name_unique on public.scheduler_courses (user_id, lower(name));

create table public.scheduler_reflections (
  user_id uuid not null references auth.users(id) on delete cascade,
  week date not null check (extract(isodow from week) = 1),
  win text not null default '' check (length(win) <= 1000),
  next_step text not null default '' check (length(next_step) <= 1000),
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id, week)
);

do $$
declare table_name text;
begin
  foreach table_name in array array['scheduler_courses','scheduler_reflections'] loop
    execute format('alter table public.%I enable row level security', table_name);
    execute format('revoke all on public.%I from anon, public', table_name);
    execute format('grant select, insert, update, delete on public.%I to authenticated', table_name);
    execute format('create policy owner_access on public.%I for all to authenticated using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id)', table_name);
    execute format('create trigger update_version before update on public.%I for each row execute function public.scheduler_touch()', table_name);
    execute format('create index on public.%I (user_id, updated_at)', table_name);
  end loop;
end;
$$;

commit;
