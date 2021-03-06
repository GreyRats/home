;;; dired-subtree-rcp.el --- Insert subdirectories in a tree-like fashion

;;; Code:
(use-package dired-subtree
  :ensure t
  :defer t
  :after (dired)
  :bind (:map dired-mode-map
              ("i" . dired-subtree-insert)
              (";" . dired-subtree-remove))
)

(provide 'dired-subtree-rcp)
;;; Commentary:
;;
;;; dired-subtree-rcp.el ends here
