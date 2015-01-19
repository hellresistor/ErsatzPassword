# Copyright 1998 Juniper Networks, Inc.
# All rights reserved.
# Copyright (c) 2002 Networks Associates Technology, Inc.
# All rights reserved.
#
# Portions of this software was developed for the FreeBSD Project by
# ThinkSec AS and NAI Labs, the Security Research Division of Network
# Associates, Inc.  under DARPA/SPAWAR contract N66001-01-C-8035
# ("CBOSS"), as part of the DARPA CHATS research program.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote
#    products derived from this software without specific prior written
#    permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.
#
# $FreeBSD: stable/10/lib/libpam/modules/pam_unix/Makefile 230311 2012-01-18 18:26:56Z peter $

.include <bsd.init.mk>

LIB=	pam_unix
SRCS=	pam_unix.c ersatz.c
MAN=	pam_unix.8
DPADD+= ${LIBUTIL} ${LIBCRYPT}
LDADD+= -lutil -lcrypt -lpython2.7 -lm -lpthread
CC=	gcc48 $(cc-disable-warning, missing-variable-declarations) -L/usr/lib/python2.7/config ${LDADD}

.if ${MK_NIS} != "no"
CFLAGS+= -DYP
DPADD+= ${LIBYPCLNT}
LDADD+= -lypclnt
.endif

.include <bsd.lib.mk>
CFLAGS=
EXPSRC= experiments/src/
EXPBIN= experiments/bin/
exp1: pam_unix.o
	g++48 -lpam -o $(EXPBIN)exp1 $(EXPSRC)exp1.cpp

exp2: pam_unix.o
	g++48 -lpam -o $(EXPBIN)exp2 $(EXPSRC)exp2.cpp

exp3: ersatz.o
	$(CC) -I. -o $(EXPBIN)exp3 ersatz.o $(EXPSRC)exp3.c