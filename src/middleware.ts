import { NextResponse, type NextRequest } from 'next/server'
import { updateSession } from '@/utils/supabase/middleware'
import { createClient } from './utils/supabase/server'

// 認証チェックをおこなうルートを指定する
const userRouteRegex = /^\/user(\/|$)/
const adminRouteRegex = /^\/admin(\/|$)/
const authRoutes = ['/sign-in', '/sign-up']

export async function middleware(request: NextRequest) {
  await updateSession(request)

  const supabase = createClient()

  const {
    data: { user },
    error: userError,
  } = await supabase.auth.getUser()

  // 現在のルートが保護されているかパブリックかを確認する
  const path = request.nextUrl.pathname
  const isUserRoute = userRouteRegex.test(path)
  const isAdminRoute = adminRouteRegex.test(path)
  const isAuthRoute = authRoutes.includes(path)

  if (isUserRoute) {
    if (!user || userError) {
      return NextResponse.redirect(new URL('/sign-in', request.nextUrl))
    }
  }

  if (isAdminRoute) {
    if (!user || userError) {
      return NextResponse.redirect(new URL('/sign-in', request.nextUrl))
    }

    const { data: userMetadata, error: userMetadataError } = await supabase
      .from('user_metadata')
      .select('role')
      .eq('id', user.id)
      .single()

    if (userMetadataError || userMetadata?.role !== 'admin') {
      return NextResponse.redirect(new URL('/user/models', request.nextUrl))
    }
  }

  if (isAuthRoute) {
    if (user) {
      return NextResponse.redirect(new URL('/user/models', request.nextUrl))
    }
  }

  return NextResponse.next()
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     * Feel free to modify this pattern to include more paths.
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}
