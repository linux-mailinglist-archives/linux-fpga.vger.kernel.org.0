Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D65757CD8
	for <lists+linux-fpga@lfdr.de>; Tue, 18 Jul 2023 15:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjGRNH1 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 18 Jul 2023 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjGRNHD (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 18 Jul 2023 09:07:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D9530D8
        for <linux-fpga@vger.kernel.org>; Tue, 18 Jul 2023 06:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689685424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wWVveJ30j+awpC6r3B537VP9iS5QEq83jfrgh734Zoc=;
        b=WAwA9Jv4vqPnFnLERuI6ojM9lIU/NBAdYhN8/uIqOS4UCwFykM59PfjCU6dDD7rHzO9GhA
        pmEVdA1iiBPxvCJkSQC267+Gz7cl2QWuRtqWTgnjkDwRo7Tj3IsrPD2F1ZAbHPr0ooRl1l
        0m9Tgn8r6U5nVyfh1baZfFOdqfAKSPU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-k6XH_oepMkqFLbjIrsGDsw-1; Tue, 18 Jul 2023 09:03:43 -0400
X-MC-Unique: k6XH_oepMkqFLbjIrsGDsw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76735d5eb86so800685285a.3
        for <linux-fpga@vger.kernel.org>; Tue, 18 Jul 2023 06:03:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685422; x=1692277422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wWVveJ30j+awpC6r3B537VP9iS5QEq83jfrgh734Zoc=;
        b=TnqNxWsIf03kD2VUY/biu5YipkU6xC7bsVLI9SWMTavwuemaSDB0qx+A+mAE/iIS2y
         fK4BMUgT8xzkd8w/tatS+CAeNgOUoRnqxduh678+5D61yXm15GnEjBtHyIFD8oTF/A8H
         M/a/c9o1ecfxkFByuUpQvJQ6rc6IVBp7l0wsPCXXnhpGdE0juQX9o1g0FQupnS4r6vFF
         T4tP65x+IyrCR6QIKv/y8YyBVj0Ft9F2hypGHl+kBPAUX4gCf9bdIUg+gWYsEzkyYvIG
         KMSMClICxworKewX+4XLg8dBv4t8XY0/LofIhbFkqqaBXr0co+FEtTpS06HwEYYHu5Sl
         uAVg==
X-Gm-Message-State: ABy/qLapA4QUhPgma+13Q71QSVqz0FECws+MsGTyYt+gnVHc5N2VWz3W
        eiJ64mSVNj8YrEwBO5GaEnws26hAvqe2MMXP4a5MuTq3RT2wLuvqIpJsE3+uZMAA9A4ZZVstkfW
        kXPziw2elVz03hG5GaOud
X-Received: by 2002:a05:620a:470e:b0:765:ab6e:53fb with SMTP id bs14-20020a05620a470e00b00765ab6e53fbmr18551804qkb.40.1689685422047;
        Tue, 18 Jul 2023 06:03:42 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHo2dahj88tgdIwzLRNbgcz8isJZIvCaDhTpJfDLLFrXuf4AikIIrEmd56tJQ1e0Thj/WFI9w==
X-Received: by 2002:a05:620a:470e:b0:765:ab6e:53fb with SMTP id bs14-20020a05620a470e00b00765ab6e53fbmr18551738qkb.40.1689685421467;
        Tue, 18 Jul 2023 06:03:41 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-27-228.cust.vodafonedsl.it. [2.34.27.228])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a10b200b00765ab6d3e81sm550221qkk.122.2023.07.18.06.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:03:41 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v10 4/4] fpga: add configuration for the FPGA KUnit test suites.
Date:   Tue, 18 Jul 2023 15:03:04 +0200
Message-ID: <20230718130304.87048-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718130304.87048-1-marpagan@redhat.com>
References: <20230718130304.87048-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add configuration for the KUnit test suites for the core components
of the FPGA subsystem.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/Kconfig            |  2 ++
 drivers/fpga/Makefile           |  3 +++
 drivers/fpga/tests/.kunitconfig |  5 +++++
 drivers/fpga/tests/Kconfig      | 11 +++++++++++
 drivers/fpga/tests/Makefile     |  6 ++++++
 5 files changed, 27 insertions(+)
 create mode 100644 drivers/fpga/tests/.kunitconfig
 create mode 100644 drivers/fpga/tests/Kconfig
 create mode 100644 drivers/fpga/tests/Makefile

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 0a00763b9f28..2f689ac4ba3a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -276,4 +276,6 @@ config FPGA_MGR_LATTICE_SYSCONFIG_SPI
 	  FPGA manager driver support for Lattice FPGAs programming over slave
 	  SPI sysCONFIG interface.
 
+source "drivers/fpga/tests/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 72e554b4d2f7..352a2612623e 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -55,3 +55,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# KUnit tests
+obj-$(CONFIG_FPGA_KUNIT_TESTS)		+= tests/
diff --git a/drivers/fpga/tests/.kunitconfig b/drivers/fpga/tests/.kunitconfig
new file mode 100644
index 000000000000..a1c2a2974c39
--- /dev/null
+++ b/drivers/fpga/tests/.kunitconfig
@@ -0,0 +1,5 @@
+CONFIG_KUNIT=y
+CONFIG_FPGA=y
+CONFIG_FPGA_REGION=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_FPGA_KUNIT_TESTS=y
diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
new file mode 100644
index 000000000000..e4a64815f16d
--- /dev/null
+++ b/drivers/fpga/tests/Kconfig
@@ -0,0 +1,11 @@
+config FPGA_KUNIT_TESTS
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
+	default KUNIT_ALL_TESTS
+        help
+          This builds unit tests for the FPGA subsystem
+
+          For more information on KUnit and unit tests in general,
+          please refer to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+          If unsure, say N.
diff --git a/drivers/fpga/tests/Makefile b/drivers/fpga/tests/Makefile
new file mode 100644
index 000000000000..bb78215c645c
--- /dev/null
+++ b/drivers/fpga/tests/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for KUnit test suites for the FPGA subsystem
+#
+
+obj-$(CONFIG_FPGA_KUNIT_TESTS) += fpga-mgr-test.o fpga-bridge-test.o fpga-region-test.o
-- 
2.41.0

