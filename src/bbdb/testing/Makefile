all: bbdb-test-results

bbdb-test-results: ../lisp bbdb-test.el
	/usr/local/bin/emacs-23.0.0 -l ~/emacs.d/fixing.el -no-site-file -no-init-file -batch -l run-tests.el >/dev/null 2>&1
	@if /bin/grep FAILED bbdb-test-results >/dev/null 2>&1; then echo "Tests failed:"; /bin/grep  -n FAILED bbdb-test-results; else echo "All tests succeeded"; fi

clean:
	/bin/rm -f bbdb-test-results
