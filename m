Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4FC1F3B51
	for <lists+linux-fpga@lfdr.de>; Tue,  9 Jun 2020 15:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgFINCg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 9 Jun 2020 09:02:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48978 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728126AbgFINCe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 9 Jun 2020 09:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591707752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=bREWkWb35OzfrHIRzdmmor2rUMQLv+plL/FvWsPvBUY=;
        b=EagjR6ezACsdkgOsY9NYO4doFcO6ezRz6CPWeL9rHDNZaQCNOhBN0B1YhMBYtCE743H5Xv
        3maOJJJfpWigLAYkc6K7f//IoAQsMlqCnQj4X++DQAfkgNslsnR6D7BkYwWHc8XlZl9Dqj
        kW+6CaXHCpOin18+ekECsBCxEv/UtSU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-e6LMoKl9PuywBIGkkbJtrw-1; Tue, 09 Jun 2020 09:02:30 -0400
X-MC-Unique: e6LMoKl9PuywBIGkkbJtrw-1
Received: by mail-qk1-f198.google.com with SMTP id 140so16970197qko.23
        for <linux-fpga@vger.kernel.org>; Tue, 09 Jun 2020 06:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bREWkWb35OzfrHIRzdmmor2rUMQLv+plL/FvWsPvBUY=;
        b=U12Q2ZXqKPsl612lQeAK9vilY/Vdp8H6nqsJzDPHFM2PjGrBPT0J8dcRsf5dYSyx1s
         3BzSeNiCMDHXrxIThRzv9ti+46vLFzndHg+SleZtneqosXJAnvW/xC3TZd0p7H0kkSw7
         GnGjviA1P1eacSKryBCsRii5l1tHGMC6V8nLkLlyZZG7Dv34LZqefpqDw0iSs7YjFLas
         4g6XiUDi7wsjhUUgW7PIqMQdCCvJ9H7CmANt3qjrfbWUuUU9+JrixCHLi71uwVlOZa6p
         Y4/PlTNtoKWaxBBuMhwbEjQpQltFDM1OVHtibQRoxppGKnB+1Xg2xhPz9i6K/FEk4S9C
         XHiA==
X-Gm-Message-State: AOAM533jvOv+Bb1NzAtlzPBsChI2YedBXzCiIxHskdmD6U680r8VPZKj
        /5Cx1/N3aW5FFMWPVT42uSUPev+47CpZXDAR9HILHJ1KvnVlgqdf1V6SfTuHnAZ1WcSzteCXCWU
        z0UMEuUOJLYgnMTxPJJ3Rrw==
X-Received: by 2002:ac8:1942:: with SMTP id g2mr29381337qtk.107.1591707749696;
        Tue, 09 Jun 2020 06:02:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG5qx7Rdh6rstfsYD4nmjRh99FD3i66w6W9E4Eo93OJSR2rUacVKoE4wgpbkgBwfiMzejw3A==
X-Received: by 2002:ac8:1942:: with SMTP id g2mr29381276qtk.107.1591707749301;
        Tue, 09 Jun 2020 06:02:29 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id m7sm9635939qti.6.2020.06.09.06.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 06:02:28 -0700 (PDT)
From:   trix@redhat.com
To:     linux-fpga@vger.kernel.org, shuah@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 1/1] selftests: fpga: dfl: A test for afu interrupt support
Date:   Tue,  9 Jun 2020 06:02:08 -0700
Message-Id: <20200609130208.27390-2-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200609130208.27390-1-trix@redhat.com>
References: <20200609130208.27390-1-trix@redhat.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
$ sudo make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
...
ok 1 selftests: drivers/fpga: afu_intr

Signed-off-by: Tom Rix <trix@redhat.com>
---
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  9 +++++
 .../testing/selftests/drivers/fpga/afu_intr.c | 38 +++++++++++++++++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 4 files changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/afu_intr.c
 create mode 100644 tools/testing/selftests/drivers/fpga/config

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 1195bd85af38..4c6eda659125 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += clone3
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..0a472e8c67c5
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := afu_intr
+
+top_srcdir ?=../../../../..
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/afu_intr.c b/tools/testing/selftests/drivers/fpga/afu_intr.c
new file mode 100644
index 000000000000..aa1efba94605
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/afu_intr.c
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <linux/fcntl.h>
+#include <linux/fpga-dfl.h>
+
+#define TEST_PREFIX	"drivers/fpga/afu_intr"
+
+int main(int argc, char *argv[])
+{
+	int devfd, status;
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0) {
+		printf("%s: [skip,no-ufpgaintr]\n", TEST_PREFIX);
+		exit(77);
+	}
+
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	irq_num = -1;
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	if (status != 0 || irq_num > 255) {
+		printf("%s: [FAIL,err-get-irq-num]\n", TEST_PREFIX);
+		close(devfd);
+		exit(1);
+	}
+
+	close(devfd);
+	return 0;
+}
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
-- 
2.18.1

