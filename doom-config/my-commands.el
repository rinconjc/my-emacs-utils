;;; my-commands.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Julio
;;
;; Author: Julio <julio@Julios-MBP.lan>
;; Maintainer: Julio <julio@Julios-MBP.lan>
;; Created: August 03, 2024
;; Modified: August 03, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/julio/my-commands
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:



(provide 'my-commands)

(defun my-commands.export-puml ()
  "Exports the current puml file to and svg file in the same directory"
  (interactive)
  (when (eq major-mode 'plantuml-mode)
    (when-let (file buffer-file-name)
      (when (or (string-suffix-p ".pum" file) (string-suffix-p ".puml" file))
        (let ((cmd-args (append (list plantuml-java-command nil nil nil)
                                (plantuml-jar-render-command "-tsvg" file))))
          (apply 'call-process cmd-args))
        (message "puml exported")))))

(defun my-commands.on-puml-save-hook ()
  (add-hook 'after-save-hook 'my-export-puml nil t))

(add-hook 'plantuml-mode-hook 'on-puml-save-hook)

(defun my-commands.kill-async-shell-buffers ()
  "Kills all the async shell buffers with terminated processes"
  (interactive)
  (seq-doseq (b  (seq-filter (lambda (b)
                               (string-prefix-p shell-command-buffer-name-async (buffer-name b)))
                             (buffer-list)))
    (when (not (get-buffer-process b))
      (kill-buffer b))))


(defun my-commands.eshell-command-async (command)
  "Run a shell COMMAND asynchronously using `start-process`.
If a region is active, use the selected text as the command.
Otherwise, prompt for a command to run."
  (interactive (list (if (use-region-p)
                         (buffer-substring-no-properties (region-beginning) (region-end))
                       (read-shell-command "Command: "))))
  (let* ((buf-name "*async eshell*")
         (cur-buffer (get-buffer buf-name))
         (buffer (if (and cur-buffer (not (get-buffer-process cur-buffer)))
                     cur-buffer
                   (generate-new-buffer buf-name))))
    (with-current-buffer buffer
      (goto-char (point-max))
      (insert (format "============= CMD: [%s] ===========\n" command))
      (add-hook 'after-change-functions 
                (lambda (beg end len)
                  (ansi-color-apply-on-region beg end))
                nil t))
    
    (start-process-shell-command command buffer command)
    
    (display-buffer buffer)))

(defun my-commands.send-command-to-eshell-terminal (command)
  "Run a shell COMMAND in an Eshell session (terminal).
Reuses an existing Eshell buffer or creates a new one if it doesn't exist."
  (interactive (list (read-shell-command "Eshell command: ")))
  ;; Ensure an Eshell buffer exists and is the current buffer.
  ;; 'eshell' command will switch to an existing one or create a new one.
  (let ((buffer (or (get-buffer "*eshell*")
                    (eshell))))
    (with-current-buffer buffer
      (goto-char (point-max))
      (insert command)
      (eshell-send-input))
    (display-buffer buffer)))

(defun my-commands.open-typescript-repl ()
  (interactive)
  (ansi-term "ts-node"))

;;; my-commands.el ends here
