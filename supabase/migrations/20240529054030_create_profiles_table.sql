create table public.profiles (
  id uuid not null references auth.users on delete cascade,
  first_name text,
  last_name text,
  first_name_kana text,
  last_name_kana text,

  primary key (id)
);

alter table public.profiles enable row level security;
