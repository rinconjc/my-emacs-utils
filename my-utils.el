(defun my-export-puml ()
  "Exports the current puml file to and svg file in the same directory"
  (interactive)
  (when (eq major-mode 'plantuml-mode)
    (when-let (file buffer-file-name)
      (when (or (string-suffix-p ".pum" file) (string-suffix-p ".puml" file))
        (let ((cmd-args (append (list plantuml-java-command nil nil nil)
                                (plantuml-jar-render-command "-tsvg" file))))
          (apply 'call-process cmd-args))
        (message "puml exported")))))

(defun on-puml-save-hook ()
  (add-hook 'after-save-hook 'my-export-puml nil t))

(add-hook 'plantuml-mode-hook 'on-puml-save-hook)
