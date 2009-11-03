
(when (require 'swank-clojure-autoload nil 'noerror)
  (swank-clojure-config
   (let* ((clojure-dir (expand-file-name "~/.clojure/"))
          (clojure-jar (concat clojure-dir "clojure.jar"))
          (contrib-jar (concat clojure-dir "clojure-contrib.jar"))
          (clojure-swank (concat clojure-dir "swank-clojure.jar")))
     (pushnew contrib-jar swank-clojure-extra-classpaths :test 'equal)
     (pushnew clojure-swank swank-clojure-extra-classpaths :test 'equal)
     (setq swank-clojure-jar-path clojure-jar))))
