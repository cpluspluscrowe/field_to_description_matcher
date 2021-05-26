(defun fill-hash-table (fields) 
  "Add all fields as keys in the hash-table"
                                        ; base case
  (if (eq (length fields) 0) nil (progn (puthash (car fields) t final) 
                                        (fill-hash-table (cdr fields)))))

(defun contains-string (look4 contains) 
  "Returns if contains look4"
  (let ((find-index   (string-match-p (regexp-quote look4) contains))) 
    (if find-index t find-index)))

(defun find-matching-key (description keys) 
  "Finds a key that matches the description"
                                        ; ensure there are keys to use
  (if (eq (length keys) 0) nil
                                        ;base case
    (if (contains-string (car keys) description) 
        (car keys) 
      (find-matching-key description (cdr keys)))))

(defun find-description-for-key (key descriptions)
  "find matching description for a key"
  (if (eq (length descriptions) 0) nil (if (contains-string key (car descriptions)) 
                                           (car descriptions) 
                                         (find-description-for-key key (cdr descriptions)))))

(defun add-hash-value (descriptions ht key)
  "get the description that matches a key"
  (let ((matching-description (find-description-for-key key descriptions))) 
    (if matching-description (progn (puthash key matching-description ht) 
                                    (list key matching-description)) 
      (list key nil))))

(defun get-key-descriptions (keys descriptions ht)
  "map all keys to a corresponding description"
  (-map (-partial #'add-hash-value descriptions ht) keys))

(defun print-key-values (kds) 
  "Print out each key and description in a csv format"
  (if (eq (length kds) 0) nil           ; returns nil each time
    (progn (message "%s|%s\n" (nth 0 (car kds)) 
                    (nth 1 (car kds))) 
           (print-key-values (cdr kds)))))

(setq fields-raw (f-read-text "fields.txt" 'utf-8))
(setq fields (butlast (split-string fields-raw "\n")))

(setq descriptions-raw (f-read-text "descriptions.txt" 'utf-8))
(setq descriptions (butlast (split-string descriptions-raw "\n")))

(setq final (make-hash-table :test #'equal))
(fill-hash-table fields)
(setq key-descriptions (get-key-descriptions (hash-table-keys final) descriptions final))

(print-key-values key-descriptions)
