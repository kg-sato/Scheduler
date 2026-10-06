-- Local migration draft for a Supabase/Postgres backend. Not applied to any server.
-- Existing browser data remains local until authenticated sync is implemented.
begin;

create table public.scheduler_assignments (
  user_id uuid not null references auth.users(id) on delete cascade,
  id text not null,
  title text not null check (length(title) between 1 and 160),
  course text not null default '' check (length(course) <= 60),
  due date not null,
  estimate_minutes integer not null check (estimate_minutes > 0),
  done boolean not null default false,
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id, id)
);

create table public.scheduler_steps (
  user_id uuid not null,
  assignment_id text not null,
  id text not null,
  title text not null check (length(title) between 1 and 120),
  minutes integer not null check (minutes in (30,60,90,120)),
  done boolean not null default false,
  position integer not null check (position >= 0),
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id, id),
  foreign key (user_id, assignment_id) references public.scheduler_assignments(user_id,id) on delete cascade
);

-- Actual occurrences have event_date; template rows have weekday only.
create table public.scheduler_events (
  user_id uuid not null references auth.users(id) on delete cascade,
  id text not null,
  scope_key text not null,
  event_date date,
  weekday smallint check (weekday between 0 and 6),
  title text not null check (length(title) between 1 and 160),
  start_minute integer not null check (start_minute >= 360 and start_minute % 30 = 0),
  end_minute integer not null check (end_minute <= 1380 and end_minute % 30 = 0),
  course text not null default '',
  kind text not null default 'event' check (kind in ('event','class','study','work','personal')),
  color text not null check (color ~ '^#[0-9a-fA-F]{6}$'),
  notes text not null default '',
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id, scope_key, id),
  check (end_minute > start_minute),
  check ((event_date is not null and weekday is null) or (event_date is null and weekday is not null))
);

create table public.scheduler_preferences (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}' check (jsonb_typeof(data) = 'object'),
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz
);

create table public.scheduler_focus_sessions (
  user_id uuid not null references auth.users(id) on delete cascade,
  id text not null,
  assignment_id text,
  session_date date not null,
  title text not null default '',
  minutes integer not null check (minutes in (25,50,90)),
  version bigint not null default 1,
  updated_at timestamptz not null default now(),
  deleted_at timestamptz,
  primary key (user_id,id)
);

-- Clients must send expected version on update, and treat zero updated rows as a conflict.
-- Incrementing the version alone is not a complete synchronization protocol.
create function public.scheduler_touch() returns trigger
language plpgsql set search_path = '' as $$
begin
  new.version := old.version + 1;
  new.updated_at := now();
  return new;
end;
$$;

do $$
declare table_name text;
begin
  foreach table_name in array array['scheduler_assignments','scheduler_steps','scheduler_events','scheduler_preferences','scheduler_focus_sessions'] loop
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
