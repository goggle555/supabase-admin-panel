create function public.handle_new_user()
returns trigger
language plpgsql
security definer set search_path = ''
as $$
begin
  insert into public.profiles (id, first_name, last_name, first_name_kana, last_name_kana)
  values (new.id, new.raw_user_meta_data ->> 'first_name', new.raw_user_meta_data ->> 'last_name', new.raw_user_meta_data ->> 'first_name_kana', new.raw_user_meta_data ->> 'last_name_kana');
  return new;
end;
$$;
