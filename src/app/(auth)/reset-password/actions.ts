'use server'

import { createClient } from '@/utils/supabase/server'
import { redirect } from 'next/navigation'

export async function requestResetPassword(formData: FormData) {
  const supabase = createClient()

  const email = formData.get('email') as string

  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo: `${location.origin}/api/auth/callback?next=${location.origin}/reset-password`,
  })

  if (error) {
    throw error
  }
}

export async function resetUserPassword(formData: FormData) {
  const supabase = createClient()

  const password = formData.get('password') as string

  const { error } = await supabase.auth.updateUser({ password })

  if (error) {
    throw error
  }

  await supabase.auth.signOut()

  redirect('/sign-in')
}
