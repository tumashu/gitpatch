;;; gitpatch.el --- Utils of Git-format patch file

;; * Header
;; #+BEGIN_EXAMPLE
;; Copyright (C) 2017 Feng Shu

;; Author: Feng Shu <tumashu@163.com>
;; Homepage: https://github.com/tumashu/gitpatch
;; Keywords: convenience
;; Package-Requires: ((cl-lib "0.5"))
;; Version: 0.10

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;; #+END_EXAMPLE

;;; Commentary:

;; * What is gitpatch                                      :README:
;; Utils of git-format patch file, which include:

;; 1. `gitpatch-mail' Quick send a git-format patch file with message-mode
;;    or its derived mode.

;; ** Installation

;; 1. Config melpa source, please read: [[http://melpa.org/#/getting-started]]
;; 2. M-x package-install RET gitpatch RET

;; ** Configure

;; #+BEGIN_EXAMPLE
;; (require 'gitpatch)
;; #+END_EXAMPLE

;; ** Usage
;; *** gitpatch-mail
;; 1. Move the point to the patch-name in magit-status buffer or dired buffer.
;;    NOTE: Other buffer type can be supported with the help of
;;    `gitpatch-mail-get-patch-functions'
;; 2. M-x gitpatch-mail
;; 3. Select an email address as TO Field, if you set `gitpatch-mail-database'.
;; 3. Edit and send email.

;;; Code:

;; * gitpatch's code                                                        :code:
(require 'cl-lib)


(defgroup gitpatch nil
  "Utils for Git-format patch file."
  :prefix "gitpatch-"
  :group 'applications)

(defcustom gitpatch-mail-function 'message-mail
  "The function used to compose patch mail, you can
choose `message-mail' or `gnus-msg-mail'."
  :group 'gitpatch
  :type 'function)

(defcustom gitpatch-mail-get-patch-functions
  '(gitpatch-mail-get-patch-from-magit
    gitpatch-mail-get-patch-from-dired)
  "A list of function, which used to get git patch
file's patch."
  :group 'gitpatch)

(defcustom gitpatch-mail-database nil
  "A list of email address, user can select an
email address as TO field."
  :group 'gitpatch)

(defun gitpatch-mail--patch-file-p (file)
  "Test a file is a patch file."
  (and file (stringp file)
       (file-readable-p file)
       (string-match-p "\\.patch$" file)))

(defun gitpatch-mail--get-patch-file ()
  "Get a git-format patch's full patch."
  (let ((file (or (cl-some (lambda (func)
                             (when (functionp func)
                               (funcall func)))
                           gitpatch-mail-get-patch-functions)
                  (gitpatch-mail-get-patch-from-minibuffer))))
    (unless file
      (message "[Gitpatch]: the selected file is not a patch file."))
    file))

(defun gitpatch-mail-get-patch-from-magit ()
  "Get a git-format patch's full path from magit buffer."
  (when (eq major-mode 'magit-status-mode)
    (let ((dir magit--default-directory)
          (file-name (magit-file-at-point)))
      (when (and (stringp dir)
                 (stringp file-name))
        (let ((file (concat (file-name-as-directory dir)
                            file-name)))
          (when (gitpatch-mail--patch-file-p file)
            file))))))

(defun gitpatch-mail-get-patch-from-minibuffer ()
  "Get a git-format patch's full path from minibuffer."
  (let ((file (read-file-name "[Gitpatch]: please select a patch: ")))
    (when (gitpatch-mail--patch-file-p file)
      file)))

(defun gitpatch-mail-get-patch-from-dired ()
  "Get a git-format patch's full path from dired buffer."
  (when (eq major-mode 'dired-mode)
    (let ((file (dired-file-name-at-point)))
      (when (gitpatch-mail--patch-file-p file)
        file))))

(defun gitpatch-mail--extract-subject (patch-file)
  "Extract subject from git-format patch file."
  (when (and patch-file
             (stringp patch-file)
             (file-readable-p patch-file))
    (with-temp-buffer
      (insert-file-contents patch-file)
      (goto-char (point-min))
      (buffer-substring-no-properties
       (re-search-forward "^ *Subject: +")
       (line-end-position)))))

;;;###autoload
(defun gitpatch-mail ()
  "Mail a git-format patch file message-mode or its derived mode."
  (interactive)
  (let* ((file (gitpatch-mail--get-patch-file))
         (subject (gitpatch-mail--extract-subject file))
         (to (when gitpatch-mail-database
               (if (= (length gitpatch-mail-database) 1)
                   (car gitpatch-mail-database)
                 (completing-read "TO: " gitpatch-mail-database)))))
    (when file
      (funcall gitpatch-mail-function to subject)
      (mml-attach-file file "text/x-patch" subject "inline"))))


(provide 'gitpatch)

;; * Footer

;; Local Variables:
;; coding: utf-8-unix
;; End:

;;; gitpatch.el ends here
