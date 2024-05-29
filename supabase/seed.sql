DO $SEED$
DECLARE
  test_user  auth.users%ROWTYPE;
  test_admin auth.users%ROWTYPE;
BEGIN

-- テストユーザー
insert into "auth"."users"
  (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous)
values
  ('00000000-0000-0000-0000-000000000000', 'b6f3737e-416c-4d82-9112-ea3506b2b1d2', 'authenticated', 'authenticated', 'test-user@example.com', '$2a$10$/qDwL/zQ4dtFQ6kTr7lOKeBQz/pjWdikg6VMPUlJQ9WWb7xiPBDvO', '2024-05-09 07:23:44.735603+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"first_name": "ユーザー", "last_name": "テスト", "first_name_kana": "ゆーざー", "last_name_kana": "てすと"}', NULL, '2024-05-09 07:23:44.731654+00', '2024-05-09 07:23:44.73574+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false)
returning * into test_user;

-- テスト管理者ユーザー
insert into "auth"."users"
  (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous)
values
  ('00000000-0000-0000-0000-000000000000', 'baf3c969-306f-4861-9786-c6f8e10cfdee', 'authenticated', 'authenticated', 'test-admin@example.com', '$2a$10$BGR3nQRtcmdaGeyl/UwxwesotR0ZHUK8etpTIG4XfzsI3EDDNHfmO', '2024-05-09 09:09:47.652803+00', NULL, '', NULL, '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"first_name": "管理者", "last_name": "テスト", "first_name_kana": "かんりしゃ", "last_name_kana": "てすと"}', NULL, '2024-05-09 09:09:47.647684+00', '2024-05-09 09:09:47.652965+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false)
returning * into test_admin;

insert into "auth"."identities"
  (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id)
values
  (test_user.id, test_user.id, '{"sub": "test_user.id", "email": "test-user@example.com", "email_verified": false, "phone_verified": false}', 'email', '2024-05-09 07:23:44.733127+00', '2024-05-09 07:23:44.733154+00', '2024-05-09 07:23:44.733154+00', '6612a195-c32d-467f-99a2-04e6702988a7'),
  (test_admin.id, test_admin.id, '{"sub": "test_admin.id", "email": "test-admin@example.com", "email_verified": false, "phone_verified": false}', 'email', '2024-05-09 09:09:47.649916+00', '2024-05-09 09:09:47.649946+00', '2024-05-09 09:09:47.649946+00', '058e818e-906d-4485-afc7-692c093a2a93');

END $SEED$
