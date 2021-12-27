# Restart Gitpod tasks

If you ever felt the need of pressing a button to restart a gitpod task interactively, you could use such a task approach. I might create an external script to hook in more easily.

```yml
# Commands to start on workspace startup
tasks:
  - command: |
      function regptask() {
        touch /workspace/stuff
        # Do more stuff
      }

      # Run the job once
      regptask;
  
      while true; do {
        read -rp "Press Enter key to re-run task" && regptask;
      } done
```