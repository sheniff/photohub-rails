ToDo
====

TEST
----
* Unit test for pictures
* Collaboration tests
  - Collaborator has to accept invitation to collaborate
  - Collaborator can add/remove pictures (only their own pictures)
  - Only collaborator can edit it's own pictures (name)
  - Owner can remove EVERY picture
  - Only owner can edit album info

HTML (base)
----
* Share albums (to let them add pics)

* Set proper permissions for editing and removing images
* List collaborators
  - Owner can add/remove new collaborators
* List invitations (collaborators that still didn't accept the invitation)
* List pendant invitations for every user
  - Let the user to accept/reject it (if they have an invitation, of course)
* List collaborating albums along with user's own albums
* Download album
* Set album as public
* Let people to login with FB, Google, Twitter, or Dropbox

API
---
* Collaborations
  // for signed in users
  - /collaborations             (accepted invitations, current collaborations)
  - /collaborations/pendant     (still not accepted invitations)
  - /collaborations/:id/accept
  - /collaborations/:id/reject  (no matter if the user is still collaborating or not)


JS APP
------
* Show cool album with thumbnails
