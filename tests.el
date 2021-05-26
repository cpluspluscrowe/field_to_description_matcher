(ert-deftest 
    contains-string
    ()
  "ensure contains string returns the correct values"
  (should (equal (contains-string "who" "whoever") t)) 
  (should (equal (contains-string "who" "no") nil)))

(ert-deftest 
    find-matching-key
    ()
  "should find a key that matches from the has-table"
  (let ((test-hash (make-hash-table :test #'equal)) 
        (description "foo and bar") 
        (descriptions (list "foo and bar" "who")) 
        (key "foo")) 
    (should (equal (find-matching-key description (hash-table-keys test-hash)) nil)) 
    (puthash key t test-hash) 
    (should (equal (find-matching-key description (hash-table-keys test-hash)) "foo"))))

(should (equal (find-description-for-key "who" (list "who" "what")) "who"))
(should (equal (find-description-for-key "what" (list "who" "what")) "what"))
(setq test-hash (make-hash-table :test #'equal))                                        ;(hash-table-values test-hash)
(setq key "foo")
(puthash key t test-hash)
(setq descriptions (list "foo2" "bar2"))
                                        ;(hash-table-values test-hash)
                                        ;(hash-table-keys test-hash)
                                        ;(should (equal (add-hash-value key descriptions test-hash) "foo2"))

(get-key-descriptions (hash-table-keys) descriptions test-hash)
(-map (-partial #'add-hash-value descriptions test-hash) 
      (hash-table-keys test-hash))
(get-key-descriptions (hash-table-keys test-hash) descriptions test-hash)
