(defconst jklblog-glog-directory-sentinel "_config.yml"
  "A file name to identify the top level of a jekyll blog
  site. To find the top-level directory of a blog, starting from
  any of its subdirectories, we search up directories until
  finding one that contains a file with this name.")

(defconst jklblog-tags-directory-relative "tags/"
  "The name of the tags directory, relative to the top-level blog
  directory.")
  
(defun jklblog-blog-directory-for-file (file)
  "Identify the top-level blog directory for FILE. Returns nil if
FILE is not part of a Jekyll blog."
  (locate-dominating-file file jklblog-glog-directory-sentinel))

(defun jklblog-posts-directory (blog-directory)
  "Returns the posts directory for the blog, given the blog's
top-level directory."
  (concat blog-directory "_posts/"))

(defun jklblog-drafts-directory (blog-directory)
  "Returns the drafts directory for the blog, given the blog's
top-level directory."
  (concat blog-directory "_drafts/"))

(defun jklblog-tags-directory (blog-directory)
  "Identify the tags directory for the blog containing
FILE. Returns nil if FILE is not part of a Jekyll blog, or if no
tags directory has been created."
  (let ((tags-directory (concat blog-directory jklblog-tags-directory-relative)))
    (if (file-accessible-directory-p tags-directory)
	tags-directory)))

(defun jklblog-post-files (blog-directory &optional include-drafts)
  "Returns a list of all posts in the blog. If INCLUDE-DRAFTS is
non-nil, then drafts are included in the results."
  (append (if include-drafts (jklblog-draft-files blog-directory))
	  (directory-files-recursively (jklblog-posts-directory blog-directory) "\\.md$")))

(defun jklblog-draft-files (blog-directory)
  "Returns a list of all drafts in the blog."
  (directory-files (jklblog-drafts-directory blog-directory) t "\\.md$"))

(defun jklblog-front-matter-string (file)
  "If a file has valid YAML front matter, returns all text
between the opening an closing '---' lines. If no front matter is
found, returns nil."
  (with-temp-buffer
    (insert-file-contents file)
    (save-match-data
      (if (search-forward-regexp
	   (rx bos "---\n" (minimal-match (group (zero-or-more anything))) "---") nil t)
	  (match-string 1)))))

(defun jklblog-front-matter-vars-from-string (string)
  "Parses a YAML front-matter string into an assoc list."
  (let ((fm-variables))
    (with-temp-buffer
      (insert string)
      (goto-char (point-min))
      (save-match-data
	(while (re-search-forward
		(rx  bol
		     (group letter (zero-or-more (or alnum "-" "_")))
		     (zero-or-more blank)
		     ":"
		     (group (zero-or-more not-newline))
		     eol)
		(point-max)
		t)
	  (push (cons (intern (downcase (match-string 1)))
		      (string-trim (match-string 2)))
		fm-variables))))
    fm-variables))

(defun jklblog-front-matter-vars (file)
  "Returns an assoc list of YAML front matter variables read from FILE."
  (jklblog-front-matter-vars-from-string (jklblog-front-matter-string file)))


(defun jklblog-list-from-yaml-list (yaml-string)
  "Parses a YAML list (such as '[tag1 tag2]) into an elisp list of strings."
  (split-string (string-trim yaml-string "\\[" "\\]") "," t (rx blank)))

(defun jklblog-post-tags (file)
  "Returns a list of tags for the given post (or draft.)"
  (jklblog-list-from-yaml-list
   (alist-get 'tags
	  (jklblog-front-matter-vars file))))

(defun jklblog-create-tag-file (tag-directory tag-name)
  "Creates/replaces a tag page file named <TAG-NAME>.html in TAG_DIRECTORY."
  (with-temp-file (concat tag-directory tag-name ".html")
    (insert "---\n"
	    "layout: tag\n"
	    "title: \"Tag: " tag-name "\"\n"
	    "tag: " tag-name "\n"
	    "permalink: /tags/" tag-name "\n"
	    "jklblog-auto-generated: true\n"
	    "---\n")
    tag-name))

(defun jklblog-auto-generated-tag-p (file)
  "Returns t iff FILE is an auto-generated tag page file."
  (string-equal (alist-get 'jklblog-auto-generated (jklblog-front-matter-vars file)) "true"))

(defun jklblog-auto-generated-tag-files (tag-directory)
  "Returns a list of all auto-generated tag page files in TAG-DIRECTORY."
  (seq-filter #'jklblog-auto-generated-tag-p
	      (directory-files tag-directory t "\\.html$")))

(defun jklblog-clear-tag-files (tags-directory)
  "Deletes all auto-generated tag page files in TAG-DIRECTORY. Returns a list of deleted tag names."
  (mapcar (lambda (file)
	    (let ((tag (alist-get 'tag (jklblog-front-matter-vars file))))
	      (delete-file file nil)
	      tag))
	  (jklblog-auto-generated-tag-files tags-directory)))

(defun jklblog-create-tags-for-post (file)
  "Auto generates tag page files for the post in FILE. Returns a list of the posts's tags."
  (let ((tags-directory (jklblog-tags-directory (jklblog-blog-directory-for-file file))))
    (mapcar (lambda (tag-name)
	      (jklblog-create-tag-file tags-directory tag-name)
	      )
	    (jklblog-post-tags file))))

(defun jklblog-tags-from-all-posts (blog-directory &optional include-drafts)
  (let ((tag-names))
    (dolist (post (jklblog-post-files blog-directory include-drafts))
      (dolist (tag (jklblog-post-tags post))
	(when (not (member tag tag-names))
	  (push tag tag-names))))
    (sort tag-names 'string-lessp)))

(defun jklblog-rebuild-tag-files (blog-directory &optional include-drafts)
  (let ((tag-directory (jklblog-tags-directory blog-directory))
	(tag-names (jklblog-tags-from-all-posts blog-directory include-drafts)))
    (jklblog-clear-tag-files tag-directory)
    (dolist (tag-name tag-names)
      (jklblog-create-tag-file tag-directory tag-name))
    tag-names))
