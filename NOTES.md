## Project TODO

1. Linux PrivEsc Enumeration Tool
Goal

Build your own lightweight version of Linpeas:
Start simple:

Kernel info
User/group info
Sudo permissions
Writable directories
SUID binaries
SGID binaries
Running services
Weak file permissions

Then expand:

Detect vulnerable sudo versions
Detect writable systemd services
Detect docker/lxc membership
Detect NFS misconfigs
Detect wildcard injection opportunities


## Architecture Design LOGIC

```bash
linux-enum/
│
├── enum.sh
│
├── modules/
│   ├── kernel.sh
│   ├── users.sh
│   ├── sudo.sh
│   ├── suid.sh
│   ├── sgid.sh
│   ├── services.sh
│   ├── docker.sh
│   ├── cron.sh
│   └── permissions.sh
│
└── utils/
    ├── colors.sh
    └── helpers.sh
```

- Store each sh into a different file and then do the following.

```bash
#!/bin/bash

bash modules/kernel.sh
bash modules/users.sh
bash modules/sudo.sh
bash modules/suid.sh
bash modules/services.sh
bash modules/docker.sh

# something like this 
# create an entry point and run each bash script file from there
# this is a good idea
# divides each script into a structure
```


As architecture grows

```bash
linux-enum/

enum.sh

modules/
    kernel.sh
    users.sh
    sudo.sh
    suid.sh
    sgid.sh
    permissions.sh
    services.sh
    docker.sh
    lxc.sh
    nfs.sh
    cron.sh
    capabilities.sh
    passwords.sh
    network.sh
    systemd.sh
    exploits.sh

utils/
    colors.sh
    helpers.sh
    banner.sh
    logger.sh
```

## PROJECT FEATURES

```bash
# Linux Privilege Escalation Enumeration Framework Roadmap

## Project Philosophy

Don't build "another LinPEAS clone."

Build your own Linux Enumeration Framework.

The goal isn't to simply find SUID files or print system information. The goal is to understand **why** every check exists, how Linux works internally, and how to organize a professional security tool.

For every feature you implement, ask yourself:

1. What Linux subsystem am I interacting with?
2. Why is this important for privilege escalation?
3. How would I verify this manually?
4. Can I explain this concept to someone else?

If the answer is yes, you've learned something valuable.

---

# Phase 1 — Foundation (System Discovery)

Goal:
Answer the question:

"What machine am I currently on?"

Topics

- Distribution
- Kernel Version
- Architecture
- Hostname
- Uptime
- Current Shell
- Init System
- Virtual Machine Detection
- Container Detection
- CPU Information
- Memory Information

Concepts Learned

- Linux system information
- /proc
- /sys
- Distribution identification
- Boot process

---

# Phase 2 — User Enumeration

Goal

Understand who the current user is and what privileges they already possess.

Topics

- Current User
- User ID
- Group Membership
- Login Shell
- Home Directory
- All Users
- Service Accounts
- Logged-in Users
- User Sessions
- User-owned Processes

Think Like an Attacker

- Which groups provide extra privileges?
- Which users are interesting?
- Which accounts can log in?
- Which user owns privileged processes?

---

# Phase 3 — Environment Enumeration

Goal

Identify information leaks from the user's environment.

Topics

- PATH
- HOME
- SHELL
- Environment Variables
- SSH Configuration
- SSH Keys
- Shell History
- Interesting Variables
- Tokens
- API Keys

Concept

Attackers often gain valuable information before privilege escalation.

---

# Phase 4 — Filesystem Enumeration

Goal

Understand the filesystem from an attacker's perspective.

Topics

- Writable Directories
- Writable Files
- Writable Configuration Files
- Writable Executables
- Writable Scripts
- Writable Startup Files

Special Permissions

- SUID
- SGID
- Sticky Bit
- Linux Capabilities
- ACLs
- Immutable Files

Interesting Files

- Password Files
- Shadow
- Backup Files
- SSH Keys
- Database Credentials
- API Keys
- Configuration Files

Concept

Every permission has a purpose.
Understand why each one matters.

---

# Phase 5 — Process Enumeration

Goal

Understand what is currently running.

Topics

- Running Processes
- Root Processes
- Process Owners
- Parent Processes
- Custom Applications
- Interesting Services
- Long-running Processes

Questions

- Which services run as root?
- Are any custom binaries running?
- Can any running process be abused?

---

# Phase 6 — Scheduled Tasks

Goal

Look for automatic execution opportunities.

Topics

- Cron Jobs
- User Cron
- System Cron
- anacron
- systemd Timers
- rc.local

Questions

- Can these be modified?
- Are they writable?
- Do they execute as root?

---

# Phase 7 — Networking

Goal

Discover trust relationships.

Topics

- Listening Ports
- Local Services
- Active Connections
- Unix Domain Sockets
- DNS Configuration
- Routing
- Firewall Rules
- NFS
- SMB
- Docker Socket

Think

What services trust localhost?

---

# Phase 8 — Service Enumeration

Goal

Analyze installed services.

Topics

- systemd Services
- Init Scripts
- Service Files
- Service Owners
- Writable Service Files
- Writable Executables
- Environment Files

Questions

Can this service be hijacked?

---

# Phase 9 — Container Enumeration

Goal

Identify container environments.

Topics

- Docker
- Podman
- LXC
- Kubernetes
- Docker Groups
- Docker Socket
- Mounted Volumes

Questions

Is container escape possible?

---

# Phase 10 — Software Enumeration

Goal

Identify vulnerable software.

Topics

- sudo
- pkexec
- polkit
- screen
- tmux
- snap
- Docker
- Kernel Modules
- Installed Packages

Advanced

Cross-reference versions with known privilege escalation vulnerabilities.

---

# Phase 11 — Configuration Analysis

Goal

Interpret findings.

Don't simply print

"There is a sudoers file."

Instead explain

"This sudo configuration allows passwordless execution."

Don't simply report

"World writable."

Instead explain

"This writable service binary could allow service hijacking."

The tool should analyze, not only collect.

---

# Phase 12 — Privilege Escalation Heuristics

Goal

Combine multiple findings into possible attack paths.

Examples

User belongs to Docker group
+
Docker Installed
=
Possible Docker privilege escalation.

Writable systemd service
+
Runs as root
=
Possible service hijacking.

Kernel version
+
Known vulnerability
=
Possible kernel privilege escalation.

The tool begins thinking instead of listing.

---

# Phase 13 — Reporting

Instead of dumping text, organize findings.

Example Categories

Critical

High

Medium

Low

Information

Or

Credentials

Permissions

Kernel

Users

Services

Containers

Networking

Software

Readable output matters.

---

# Phase 14 — Confidence Levels

Every finding should indicate confidence.

Possible

Likely

Confirmed

Informational

Not every issue is exploitable.

---

# Phase 15 — Modular Architecture

Each module should have one responsibility.

Example Modules

Kernel

Users

Filesystem

Permissions

SUID

Capabilities

Processes

Networking

Services

Docker

Containers

Cron

Software

Credentials

This keeps the project maintainable and scalable.

---

# Phase 16 — Scan Modes

Support different execution modes.

Examples

Quick Scan

Deep Scan

Verbose Mode

Stealth Mode

Module Selection

Kernel Only

Permissions Only

Containers Only

Frameworks should be flexible.

---

# Phase 17 — Output Formats

Support multiple output formats.

Console

Markdown

JSON

HTML

Professional tools integrate with other tools.

---

# Phase 18 — Logging

Track

Errors

Warnings

Skipped Checks

Permission Failures

Execution Time

Logs make debugging much easier.

---

# Phase 19 — Performance Optimization

Think about efficiency.

Avoid duplicate filesystem traversal.

Cache expensive operations.

Run independent modules in parallel.

Allow users to skip slow modules.

Professional tools balance completeness and speed.

---

# Phase 20 — Documentation

Document every module.

For each one explain

- What it checks
- Why it matters
- Which Linux subsystem it uses
- Manual verification steps
- Possible attack scenarios
- Common false positives

The documentation should teach Linux, not just explain the code.

---

# Final Goal

This project should demonstrate:

✔ Bash scripting
✔ Linux internals
✔ Filesystem permissions
✔ Process management
✔ Service analysis
✔ Networking fundamentals
✔ Privilege escalation methodology
✔ Security tooling architecture
✔ Modular software design
✔ Documentation skills

The finished project should show that you understand Linux from a security engineer's perspective—not because you copied checks from existing tools, but because you know why each check exists and how it contributes to privilege escalation assessment.
```

bash scripting learn 
- [bash scripting](https://youtu.be/tK9Oc6AEnR4?si=l6bgD1SIp5J40bIh)