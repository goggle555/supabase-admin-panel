import * as React from 'react'
import { Body, Head, Html } from '@react-email/components'

export default function UserInvitationMail() {
  return (
    <Html>
      <Head />
      <Body>
        <h2>You have been invited</h2>
        <p>
          {
            'You have been invited to create a user on {{ .SiteURL }}. Follow this link to accept the invite:'
          }
        </p>
        <p>
          <a href='{{ .ConfirmationURL }}'>Accept the invite</a>
        </p>
      </Body>
    </Html>
  )
}
