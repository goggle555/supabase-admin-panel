import { resetUserPassword, requestResetPassword } from './actions'

export default function ResetPasswordPage({
  searchParams: { url, code },
}: {
  searchParams: { url: string; code: string }
}) {
  if (url && !code) {
    return (
      <div>
        <a href={url}>パスワードをリセットする</a>
      </div>
    )
  }

  if (code && !url) {
    return (
      <div>
        <form>
          <label htmlFor='email'>Email:</label>
          <input id='email' name='email' type='email' required />
          <button formAction={resetUserPassword}>Reset My Password</button>
        </form>
      </div>
    )
  }

  return (
    <div>
      <form>
        <label htmlFor='email'>Email:</label>
        <input id='email' name='email' type='email' required />
        <button formAction={requestResetPassword}>
          Request Reset Password
        </button>
      </form>
    </div>
  )
}
