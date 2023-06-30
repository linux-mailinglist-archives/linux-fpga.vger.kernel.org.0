Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB9743EE2
	for <lists+linux-fpga@lfdr.de>; Fri, 30 Jun 2023 17:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjF3P13 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 30 Jun 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbjF3P1H (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Fri, 30 Jun 2023 11:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864CF3C22
        for <linux-fpga@vger.kernel.org>; Fri, 30 Jun 2023 08:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688138747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rGGDOW/9MqaKjCCuoAeyhkddjPlv60nFOxRpD56k1bo=;
        b=brYVOwsq8Rg0+RaAN7Ja6Zd2BVDNNzfiNfXV28PyW38ha5UWZg5ON+0WDjVDAidreKvz5a
        Eiw0pR1rzduYlAUAtqgnxwE0h1B/19QoVFfsxwRB6OWNi4ibQZc2N9UJrEdc/MI7UFzP9O
        FX13aPrWHcJ3M4LCSQ3aw67jHF5r2Z0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-318-QHda-8q-OQSzpuR-cZ8VdA-1; Fri, 30 Jun 2023 11:25:46 -0400
X-MC-Unique: QHda-8q-OQSzpuR-cZ8VdA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-51dd5868fddso2389316a12.1
        for <linux-fpga@vger.kernel.org>; Fri, 30 Jun 2023 08:25:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688138745; x=1690730745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rGGDOW/9MqaKjCCuoAeyhkddjPlv60nFOxRpD56k1bo=;
        b=SDJxXmcuTgXYS5/FmirFR3loaV0edMqU1Glnfx4rI2cSPElxhyYcQ5kelVwDi4HFL1
         E2inwQdF7FafgAWqsRWGdmkQophoC0YeLXXlhi2Y+2E/Y4PzpZYqIZnDyucfC82Yg2t7
         1zdU2PbojrJ3Om3RB3NkDFNP6dPPxaJUSOppNXA3m+rSA8y3AvdNxWHBMUDx3V8k4CSz
         pAMvLf2EB2yHzzP98XxUa8vRo6rCwXnt73Vl4LtcEiQ98TwrjWt+TYE56FVgvFA0Ko9o
         kr//eZE1BW4cLAl431N0m6ig6zaEQZaIY3Ogv+yYueYXnSg9ixXABkmOpwe9XTlWzxVc
         BkNQ==
X-Gm-Message-State: ABy/qLbEaeNh9ncywWJ2ZjAX98Agrl8ug7sUiKzNYITSZWc61Xu7QZo6
        4NoWuNzUiQPlOz0uXIkftCd5bR6jvvmXT3OMvE3kFLft8UPZE2niMVrk5jSKpP2gELCJsHjGsrD
        V80y1OJETjxoXzbx3I8PKSesGtVQK
X-Received: by 2002:aa7:c398:0:b0:51d:e2ee:33ff with SMTP id k24-20020aa7c398000000b0051de2ee33ffmr3567014edq.7.1688138745274;
        Fri, 30 Jun 2023 08:25:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFXxmvZEGcnejUR+XfxT+Fn8P/5pYATOMHIPPdbQMd40IijySgfCOV/OB4B0eMkCQcsZpst2w==
X-Received: by 2002:aa7:c398:0:b0:51d:e2ee:33ff with SMTP id k24-20020aa7c398000000b0051de2ee33ffmr3567000edq.7.1688138745060;
        Fri, 30 Jun 2023 08:25:45 -0700 (PDT)
Received: from klayman.station (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id k24-20020aa7c398000000b0051def9be785sm813230edq.85.2023.06.30.08.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 08:25:44 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v8 4/4] fpga: add configuration for the FPGA KUnit test suites.
Date:   Fri, 30 Jun 2023 17:25:07 +0200
Message-ID: <20230630152507.30219-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230630152507.30219-1-marpagan@redhat.com>
References: <20230630152507.30219-1-marpagan@redhat.com>
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

