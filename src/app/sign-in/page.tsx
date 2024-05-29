import { signIn } from './actions'

export default function SignInPage() {
  return (
    <form>
      <label htmlFor='email'>Email:</label>
      <input id='email' name='email' type='email' required />
      <label htmlFor='password'>Password:</label>
      <input id='password' name='password' type='password' required />
      <button formAction={signIn}>Log in</button>
    </form>
  )
}
