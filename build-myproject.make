api = 2
core = 7.x

;------------------------------
; Build Drupal core (with patches).
;------------------------------
includes[drupal] = drupal-org-core.make

;------------------------------
; Get profile myproject.
;------------------------------
projects[myproject][type] = profile
projects[myproject][download][type] = git
projects[myproject][download][url] = /usr/local/src/myproject
projects[myproject][download][branch] = master
