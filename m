Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5CEC302BE4
	for <lists+linux-fpga@lfdr.de>; Mon, 25 Jan 2021 20:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbhAYTmh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 25 Jan 2021 14:42:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731305AbhAYTma (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 25 Jan 2021 14:42:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611603662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=77St/2pIleVFwEn5R0u17JSkV+PiEVZKe/zUbSvXECQ=;
        b=GrWTRVWklhPa1kdfnOQ5MBD6Dmzl5Y+AzfPeaFAECMy3n9GGDEihYU21jgMBwSC2+zAlF2
        gXvIPNIFmeGCZ9caJ2m8WAXMTce4JLrSJnvvTh8ZjqY53KPu6cDk54wbvJLDiL5T7QdoKF
        wNW+eprVSaTqZLQlR1JtDMDzK3NRdtE=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-b9Mx77VpPhaN53eUqn2EEg-1; Mon, 25 Jan 2021 14:41:01 -0500
X-MC-Unique: b9Mx77VpPhaN53eUqn2EEg-1
Received: by mail-qv1-f71.google.com with SMTP id m8so9953949qvt.14
        for <linux-fpga@vger.kernel.org>; Mon, 25 Jan 2021 11:41:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=77St/2pIleVFwEn5R0u17JSkV+PiEVZKe/zUbSvXECQ=;
        b=OWmA3AqYI9js597nPGW4ubW6H/6DNWuCyKFRfZqZB8kg39tXaCqe74x0RKR4tN/4/a
         XPQkVq5AFeqldbUU+SG20XlKfrfLJxyDG36vFxjMfpBexOAkIcf202M1NuPbyuIGYjaZ
         C6pN1LcpXeMsfhOIi+drqsX7nCWXWSQPW/+52vKx4pYy83OVmSEPinRQ4fvJaXWMD5YA
         EIVd4NnP4CX261X1OMSHFLDDfzmsIfR0IHjaHNpQG5sJnMSpvl9bx09mEAZEDM+MFWyi
         0MclgA4GFqMo6ieX1HUArfp7ul+/aSQZreBxL8MdkfsMXKg3vuyZNbIr5VrFOPbdKsN5
         NObw==
X-Gm-Message-State: AOAM530GUVdORwDzYx6h8E3cA1ereayqXy9r2n9Psv4g/ejwtUjEm/LP
        EcMcAfZ1mbe3TEpJT3N6eLsLBH9tsIVMjf0p64F4XSmO2J3vUmiirdFiF3zQXtwlACgAiVfyx+n
        z72IrTz9w3SCP4joi8MjKzw==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2321887qvi.48.1611603660318;
        Mon, 25 Jan 2021 11:41:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyeWyuqh+JaKFJ1xqUU6SXIHkrrOLJPawhrtxXmDS0r1Vi15nggpu9AbTZjlBOBQdInBYXhhA==
X-Received: by 2002:a0c:c30e:: with SMTP id f14mr2321866qvi.48.1611603660045;
        Mon, 25 Jan 2021 11:41:00 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 203sm12845898qkd.81.2021.01.25.11.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:40:59 -0800 (PST)
From:   trix@redhat.com
To:     shuah@kernel.org, mdf@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v4] selftests: drivers: fpga: A test for interrupt support
Date:   Mon, 25 Jan 2021 11:40:53 -0800
Message-Id: <20210125194053.2119041-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Check that the ioctl DFL_FPGA_PORT_ERR_GET_IRQ_NUM returns
an expected result.

Tested on vf device 0xbcc1

Sample run with
 # make -C tools/testing/selftests TARGETS=drivers/fpga run_tests
 ...
 TAP version 13
 1..1
 # selftests: drivers/fpga: intr
 # TAP version 13
 # 1..1
 # # Starting 1 tests from 1 test cases.
 # #  RUN           global.afu_intr ...
 # #            OK  global.afu_intr
 # ok 1 global.afu_intr
 # # PASSED: 1 / 1 tests passed.
 # # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0
 ok 1 selftests: drivers/fpga: intr

Signed-off-by: Tom Rix <trix@redhat.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
---
v1: Convert to kselftest_harness.h framework
v2: reverse xmas tree variables
v3: rebase to linux-kselftest, tag linux-kselftest-next-5.11-rc3
---
 MAINTAINERS                                   |  1 +
 tools/testing/selftests/Makefile              |  1 +
 tools/testing/selftests/drivers/fpga/Makefile |  7 ++++
 tools/testing/selftests/drivers/fpga/config   |  1 +
 tools/testing/selftests/drivers/fpga/intr.c   | 36 +++++++++++++++++++
 5 files changed, 46 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/fpga/Makefile
 create mode 100644 tools/testing/selftests/drivers/fpga/config
 create mode 100644 tools/testing/selftests/drivers/fpga/intr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f720c72..10bea5417c82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6972,6 +6972,7 @@ F:	Documentation/driver-api/fpga/
 F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
+F:	tools/testing/selftests/drivers/fpga/
 
 FPU EMULATOR
 M:	Bill Metzenthen <billm@melbpc.org.au>
diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index afbab4aeef3c..aad4763ec348 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -9,6 +9,7 @@ TARGETS += core
 TARGETS += cpufreq
 TARGETS += cpu-hotplug
 TARGETS += drivers/dma-buf
+TARGETS += drivers/fpga
 TARGETS += efivarfs
 TARGETS += exec
 TARGETS += filesystems
diff --git a/tools/testing/selftests/drivers/fpga/Makefile b/tools/testing/selftests/drivers/fpga/Makefile
new file mode 100644
index 000000000000..eba35c405d5b
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+CFLAGS += -I../../../../../usr/include/
+CFLAGS += -I../../../../../include/uapi/
+
+TEST_GEN_PROGS := intr
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/drivers/fpga/config b/tools/testing/selftests/drivers/fpga/config
new file mode 100644
index 000000000000..e2111b81d8d7
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/config
@@ -0,0 +1 @@
+CONFIG_FPGA_DFL_AFU=m
diff --git a/tools/testing/selftests/drivers/fpga/intr.c b/tools/testing/selftests/drivers/fpga/intr.c
new file mode 100644
index 000000000000..927dcc757f0b
--- /dev/null
+++ b/tools/testing/selftests/drivers/fpga/intr.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <string.h>
+#include <sys/fcntl.h>
+#include <sys/ioctl.h>
+#include <linux/fpga-dfl.h>
+
+#include "../../kselftest_harness.h"
+
+TEST(afu_intr)
+{
+	struct dfl_fpga_port_info port_info;
+	uint32_t irq_num = UINT32_MAX;
+	int devfd, status;
+
+	devfd = open("/dev/dfl-port.0", O_RDONLY);
+	if (devfd < 0)
+		SKIP(0, "no fpga afu device 0");
+	/*
+	 * From fpga-dl.h :
+	 * Currently hardware supports up to 1 irq.
+	 * Return: 0 on success, -errno on failure.
+	 */
+	status = ioctl(devfd, DFL_FPGA_PORT_ERR_GET_IRQ_NUM, &irq_num);
+	ASSERT_EQ(0, status) {
+		TH_LOG("ioctl() failed to get the number irqs");
+	}
+	ASSERT_LT(irq_num, 256) {
+		TH_LOG("unexpeced number of irqs");
+	}
+	close(devfd);
+}
+
+TEST_HARNESS_MAIN
-- 
2.27.0

