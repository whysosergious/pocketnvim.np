
;; highlight.scm w

;;hoghlight @keywords in comments
((comment) @comment
  ; (#match? @comment "@[('|"|`|.|_|-|#|%|&|\/\\\[|\]|\(|\)|`)\\w]+)")
  (#match? @comment "@\\w+")
   (#set! @comment "Keyword"))




;; (#match? @comment "@[('|"|`|.|_|-|#|%|&|\/\\\[|\]|\(|\)|`)\\w]+)")
