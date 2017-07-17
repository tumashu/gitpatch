- [What is gitpatch](#org87289be)
  - [Installation](#org293eba2)
  - [Configure](#org545133f)
  - [Usage](#orgb6c8b3d)
    - [gitpatch-mail](#org9296254)


<a id="org87289be"></a>

# What is gitpatch

Gitpatch is git-format patch toolkit, which let user easy handle git-format patch without exit emacs.

1.  Send patch with \`gitpatch-mail'

\`gitpatch-mail' can quick send a git-format patch file from magit, dired or ibuffer buffer.


<a id="org293eba2"></a>

## Installation

1.  Config melpa source, please read: <http://melpa.org/#/getting-started>
2.  M-x package-install RET gitpatch RET


<a id="org545133f"></a>

## Configure

    (require 'gitpatch)


<a id="orgb6c8b3d"></a>

## Usage


<a id="org9296254"></a>

### gitpatch-mail

1.  Move the point to the patch-name in magit-status, dired or ibuffer buffer.
2.  M-x gitpatch-mail
3.  Select an email address as TO Field, if you set \`gitpatch-mail-database'.
4.  Add another patch with "C-c i" by default (Optional).
5.  Edit and send email.

NOTE: User can config \`gitpatch-mail' in other type buffer with the help of \`gitpatch-mail-get-patch-functions'


Converted from gitpatch.el by [el2org](https://github.com/tumashu/el2org) .