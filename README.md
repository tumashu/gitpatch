- [What is gitpatch](#orgc9ade4c)
    - [\`gitpatch-mail'](#org0f4ad11)
  - [Installation](#orge9121f5)
  - [Configure](#orga735c80)
  - [Usage](#org125d7f5)
    - [gitpatch-mail](#org1d5f3e5)


<a id="orgc9ade4c"></a>

# What is gitpatch

Utils of git-format patch file, which include the below tools:


<a id="org0f4ad11"></a>

### \`gitpatch-mail'

\`gitpatch-mail' can quick send a git-format patch file from magit, dired or ibuffer buffer.


<a id="orge9121f5"></a>

## Installation

1.  Config melpa source, please read: <http://melpa.org/#/getting-started>
2.  M-x package-install RET gitpatch RET


<a id="orga735c80"></a>

## Configure

    (require 'gitpatch)


<a id="org125d7f5"></a>

## Usage


<a id="org1d5f3e5"></a>

### gitpatch-mail

1.  Move the point to the patch-name in magit-status, dired or ibuffer buffer.
2.  M-x gitpatch-mail
3.  Select an email address as TO Field, if you set \`gitpatch-mail-database'.
4.  Edit and send email.
5.  Add another patch with "C-c i" by default (Optional).

NOTE: User can config \`gitpatch-mail' in other type buffer with the help of \`gitpatch-mail-get-patch-functions'


Converted from gitpatch.el by [el2org](https://github.com/tumashu/el2org) .