Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C6639FC6F
	for <lists+linux-fpga@lfdr.de>; Tue,  8 Jun 2021 18:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbhFHQ0O (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 8 Jun 2021 12:26:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233539AbhFHQ0F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 8 Jun 2021 12:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623169451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z30Ub+z2OjWJtR5c/iXeFpG9nHCwEt3UgVQc8aykjUY=;
        b=Mw9fBfrG05jtXtV+AKog9EcRKAVvMljmUBg47woD3XjYK/tHCHyKZchbC5Oy10ScEjGuUW
        QBrIks0bL61fA1EBGoh2zgj66lqZAUUNG9wbh6YIw2Sel1PfYTygDhBx2eTOPsiI6X69aQ
        OnJmKsmUoTShuTh7AxZRk969kYSBkLc=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-Ns2f26cHPom4cDwLuZnuOg-1; Tue, 08 Jun 2021 12:24:10 -0400
X-MC-Unique: Ns2f26cHPom4cDwLuZnuOg-1
Received: by mail-ot1-f72.google.com with SMTP id 108-20020a9d0bf50000b02903d55be6ada3so10976777oth.22
        for <linux-fpga@vger.kernel.org>; Tue, 08 Jun 2021 09:24:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z30Ub+z2OjWJtR5c/iXeFpG9nHCwEt3UgVQc8aykjUY=;
        b=aCzsTf90YHjvmqq6hOGGHsawYQS5rDMM5yBrfp7/eILgZ+hpMfxqmex1mox3V1lWn/
         1tSTx1OjGWWesHKoumyHV3s2hlTKct0k3xlOs4teA7aVO0lsrWUpR1axk+CDn0rArKfG
         rjYEfxBz+NfQ7YNZVU6Pc+8lFLmMVampQoWwDbe7EPF2/Gv7omTLthY0//pcq0eTYcDE
         sLjz6XvC1Ib/Qv0n2HSJmIdFVm/7OIDmd0rKuNUseTipwKRYuVUGPPhfhYiYE0SSedl/
         Rxz2UbJ4N0NlG+NwzMp+nk4Q63a36v6KUiD7YjY8R8tryg53QoJfZMBz38lFrA7BZNTW
         4qFA==
X-Gm-Message-State: AOAM531k06ZKt0nOTuuSLwxiUILNfXujPzs+eLb75FAg9FprCNDIQiG9
        eoSfppuK7dacIzy0EoaQOQxmPBDhJEnAKbJMG/CESk0fVIfsLqU9aiweE5AUqwQ24WgHZBmWMpK
        iI96t2W7L0qhfBBFLb6BdEw==
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr3327151oih.136.1623169448966;
        Tue, 08 Jun 2021 09:24:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/wf90qvmJyOhl8IF/LUAuCtSuS57EK6CzmLJqOBLpGIE7vechP80vuJAMtMPctg+4J7fPcg==
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr3327130oih.136.1623169448735;
        Tue, 08 Jun 2021 09:24:08 -0700 (PDT)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s4sm3225773otr.80.2021.06.08.09.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jun 2021 09:24:08 -0700 (PDT)
From:   trix@redhat.com
To:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        dinguyen@kernel.org, krzysztof.kozlowski@canonical.com,
        nava.manne@xilinx.com, yilun.xu@intel.com, davidgow@google.com,
        fpacheco@redhat.com, richard.gong@intel.com, luca@lucaceresoli.net
Cc:     linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 5/7] fpga: dfl: remove dfl- prefix on files
Date:   Tue,  8 Jun 2021 09:23:38 -0700
Message-Id: <20210608162340.3010204-7-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210608162340.3010204-1-trix@redhat.com>
References: <20210608162340.3010204-1-trix@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Tom Rix <trix@redhat.com>

It is not necessary to have a dfl- prefix on a file
when the file is in a dfl/ subdir.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 Documentation/fpga/dfl.rst                    |  4 ++--
 drivers/fpga/dfl/Makefile                     | 21 +++++++------------
 ...{dfl-afu-dma-region.c => afu-dma-region.c} |  2 +-
 .../fpga/dfl/{dfl-afu-error.c => afu-error.c} |  2 +-
 .../fpga/dfl/{dfl-afu-main.c => afu-main.c}   |  2 +-
 .../dfl/{dfl-afu-region.c => afu-region.c}    |  2 +-
 drivers/fpga/dfl/{dfl-afu.h => afu.h}         |  6 +++---
 drivers/fpga/dfl/{dfl-fme-br.c => fme-br.c}   |  2 +-
 .../fpga/dfl/{dfl-fme-error.c => fme-error.c} |  2 +-
 .../fpga/dfl/{dfl-fme-main.c => fme-main.c}   |  2 +-
 drivers/fpga/dfl/{dfl-fme-mgr.c => fme-mgr.c} |  2 +-
 .../fpga/dfl/{dfl-fme-perf.c => fme-perf.c}   |  2 +-
 drivers/fpga/dfl/{dfl-fme-pr.c => fme-pr.c}   |  4 ++--
 drivers/fpga/dfl/{dfl-fme-pr.h => fme-pr.h}   |  6 +++---
 .../dfl/{dfl-fme-region.c => fme-region.c}    |  2 +-
 drivers/fpga/dfl/{dfl-fme.h => fme.h}         |  6 +++---
 .../dfl/{dfl-n3000-nios.c => n3000-nios.c}    |  0
 drivers/fpga/dfl/{dfl-pci.c => pci.c}         |  0
 18 files changed, 31 insertions(+), 36 deletions(-)
 rename drivers/fpga/dfl/{dfl-afu-dma-region.c => afu-dma-region.c} (99%)
 rename drivers/fpga/dfl/{dfl-afu-error.c => afu-error.c} (99%)
 rename drivers/fpga/dfl/{dfl-afu-main.c => afu-main.c} (99%)
 rename drivers/fpga/dfl/{dfl-afu-region.c => afu-region.c} (99%)
 rename drivers/fpga/dfl/{dfl-afu.h => afu.h} (98%)
 rename drivers/fpga/dfl/{dfl-fme-br.c => fme-br.c} (99%)
 rename drivers/fpga/dfl/{dfl-fme-error.c => fme-error.c} (99%)
 rename drivers/fpga/dfl/{dfl-fme-main.c => fme-main.c} (99%)
 rename drivers/fpga/dfl/{dfl-fme-mgr.c => fme-mgr.c} (99%)
 rename drivers/fpga/dfl/{dfl-fme-perf.c => fme-perf.c} (99%)
 rename drivers/fpga/dfl/{dfl-fme-pr.c => fme-pr.c} (99%)
 rename drivers/fpga/dfl/{dfl-fme-pr.h => fme-pr.h} (96%)
 rename drivers/fpga/dfl/{dfl-fme-region.c => fme-region.c} (98%)
 rename drivers/fpga/dfl/{dfl-fme.h => fme.h} (95%)
 rename drivers/fpga/dfl/{dfl-n3000-nios.c => n3000-nios.c} (100%)
 rename drivers/fpga/dfl/{dfl-pci.c => pci.c} (100%)

diff --git a/Documentation/fpga/dfl.rst b/Documentation/fpga/dfl.rst
index ccc33f199df2a..696ab63d9e6bf 100644
--- a/Documentation/fpga/dfl.rst
+++ b/Documentation/fpga/dfl.rst
@@ -210,7 +210,7 @@ device and etc. Its driver module is always loaded first once the device is
 created by the system. This driver plays an infrastructural role in the
 driver architecture. It locates the DFLs in the device memory, handles them
 and related resources to common interfaces from DFL framework for enumeration.
-(Please refer to drivers/fpga/dfl.c for detailed enumeration APIs).
+(Please refer to drivers/fpga/dfl/dfl.c for detailed enumeration APIs).
 
 The FPGA Management Engine (FME) driver is a platform driver which is loaded
 automatically after FME platform device creation from the DFL device module. It
@@ -499,7 +499,7 @@ In some cases, we may need to add some new private features to existing FIUs
 framework, as each private feature will be parsed automatically and related
 mmio resources can be found under FIU platform device created by DFL framework.
 Developer only needs to provide a sub feature driver with matched feature id.
-FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl-fme-pr.c)
+FME Partial Reconfiguration Sub Feature driver (see drivers/fpga/dfl/fme-pr.c)
 could be a reference.
 
 Location of DFLs on a PCI Device
diff --git a/drivers/fpga/dfl/Makefile b/drivers/fpga/dfl/Makefile
index 724792039026f..29c9dbabd9f77 100644
--- a/drivers/fpga/dfl/Makefile
+++ b/drivers/fpga/dfl/Makefile
@@ -4,16 +4,11 @@
 obj-$(CONFIG_FPGA_DFL) += dfl.o
 obj-$(CONFIG_FPGA_DFL_AFU) += dfl-afu.o
 obj-$(CONFIG_FPGA_DFL_FME) += dfl-fme.o
-obj-$(CONFIG_FPGA_DFL_FME_BRIDGE) += dfl-fme-br.o
-obj-$(CONFIG_FPGA_DFL_FME_MGR) += dfl-fme-mgr.o
-obj-$(CONFIG_FPGA_DFL_FME_REGION) += dfl-fme-region.o
-obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000) += dfl-n3000-nios.o
-obj-$(CONFIG_FPGA_DFL_PCI) += dfl-pci.o
-
-dfl-fme-objs := dfl-fme-main.o dfl-fme-pr.o dfl-fme-error.o		\
-                dfl-fme-perf.o
-dfl-afu-objs := dfl-afu-main.o dfl-afu-region.o dfl-afu-dma-region.o	\
-                dfl-afu-error.o
-
-
-
+obj-$(CONFIG_FPGA_DFL_FME_BRIDGE) += fme-br.o
+obj-$(CONFIG_FPGA_DFL_FME_MGR) += fme-mgr.o
+obj-$(CONFIG_FPGA_DFL_FME_REGION) += fme-region.o
+obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000) += n3000-nios.o
+obj-$(CONFIG_FPGA_DFL_PCI) += pci.o
+
+dfl-fme-objs := fme-main.o fme-pr.o fme-error.o fme-perf.o
+dfl-afu-objs := afu-main.o afu-region.o afu-dma-region.o afu-error.o
diff --git a/drivers/fpga/dfl/dfl-afu-dma-region.c b/drivers/fpga/dfl/afu-dma-region.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-afu-dma-region.c
rename to drivers/fpga/dfl/afu-dma-region.c
index 02b60fde04305..1cf3acbdb0918 100644
--- a/drivers/fpga/dfl/dfl-afu-dma-region.c
+++ b/drivers/fpga/dfl/afu-dma-region.c
@@ -14,7 +14,7 @@
 #include <linux/uaccess.h>
 #include <linux/mm.h>
 
-#include "dfl-afu.h"
+#include "afu.h"
 
 void afu_dma_region_init(struct dfl_feature_platform_data *pdata)
 {
diff --git a/drivers/fpga/dfl/dfl-afu-error.c b/drivers/fpga/dfl/afu-error.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-afu-error.c
rename to drivers/fpga/dfl/afu-error.c
index ab7be62173681..4e04a9de314d5 100644
--- a/drivers/fpga/dfl/dfl-afu-error.c
+++ b/drivers/fpga/dfl/afu-error.c
@@ -17,7 +17,7 @@
 #include <linux/fpga-dfl.h>
 #include <linux/uaccess.h>
 
-#include "dfl-afu.h"
+#include "afu.h"
 
 #define PORT_ERROR_MASK		0x8
 #define PORT_ERROR		0x10
diff --git a/drivers/fpga/dfl/dfl-afu-main.c b/drivers/fpga/dfl/afu-main.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-afu-main.c
rename to drivers/fpga/dfl/afu-main.c
index 7f621e96d3b8d..9681ab83c02ee 100644
--- a/drivers/fpga/dfl/dfl-afu-main.c
+++ b/drivers/fpga/dfl/afu-main.c
@@ -19,7 +19,7 @@
 #include <linux/uaccess.h>
 #include <linux/fpga-dfl.h>
 
-#include "dfl-afu.h"
+#include "afu.h"
 
 #define RST_POLL_INVL 10 /* us */
 #define RST_POLL_TIMEOUT 1000 /* us */
diff --git a/drivers/fpga/dfl/dfl-afu-region.c b/drivers/fpga/dfl/afu-region.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-afu-region.c
rename to drivers/fpga/dfl/afu-region.c
index 0804b7a0c2986..0efcdb2a388e3 100644
--- a/drivers/fpga/dfl/dfl-afu-region.c
+++ b/drivers/fpga/dfl/afu-region.c
@@ -8,7 +8,7 @@
  *   Wu Hao <hao.wu@intel.com>
  *   Xiao Guangrong <guangrong.xiao@linux.intel.com>
  */
-#include "dfl-afu.h"
+#include "afu.h"
 
 /**
  * afu_mmio_region_init - init function for afu mmio region support
diff --git a/drivers/fpga/dfl/dfl-afu.h b/drivers/fpga/dfl/afu.h
similarity index 98%
rename from drivers/fpga/dfl/dfl-afu.h
rename to drivers/fpga/dfl/afu.h
index e5020e2b1f3df..1ea7945218d57 100644
--- a/drivers/fpga/dfl/dfl-afu.h
+++ b/drivers/fpga/dfl/afu.h
@@ -14,8 +14,8 @@
  *     Henry Mitchel <henry.mitchel@intel.com>
  */
 
-#ifndef __DFL_AFU_H
-#define __DFL_AFU_H
+#ifndef __AFU_H
+#define __AFU_H
 
 #include <linux/mm.h>
 
@@ -106,4 +106,4 @@ extern const struct dfl_feature_ops port_err_ops;
 extern const struct dfl_feature_id port_err_id_table[];
 extern const struct attribute_group port_err_group;
 
-#endif /* __DFL_AFU_H */
+#endif /* __AFU_H */
diff --git a/drivers/fpga/dfl/dfl-fme-br.c b/drivers/fpga/dfl/fme-br.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-fme-br.c
rename to drivers/fpga/dfl/fme-br.c
index 3ff9f3a687ce5..ee321903b2885 100644
--- a/drivers/fpga/dfl/dfl-fme-br.c
+++ b/drivers/fpga/dfl/fme-br.c
@@ -17,7 +17,7 @@
 #include <linux/fpga/fpga-bridge.h>
 
 #include "dfl.h"
-#include "dfl-fme-pr.h"
+#include "fme-pr.h"
 
 struct fme_br_priv {
 	struct dfl_fme_br_pdata *pdata;
diff --git a/drivers/fpga/dfl/dfl-fme-error.c b/drivers/fpga/dfl/fme-error.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-fme-error.c
rename to drivers/fpga/dfl/fme-error.c
index 51c2892ec06d5..97c94a87d053b 100644
--- a/drivers/fpga/dfl/dfl-fme-error.c
+++ b/drivers/fpga/dfl/fme-error.c
@@ -19,7 +19,7 @@
 #include <linux/uaccess.h>
 
 #include "dfl.h"
-#include "dfl-fme.h"
+#include "fme.h"
 
 #define FME_ERROR_MASK		0x8
 #define FME_ERROR		0x10
diff --git a/drivers/fpga/dfl/dfl-fme-main.c b/drivers/fpga/dfl/fme-main.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-fme-main.c
rename to drivers/fpga/dfl/fme-main.c
index 77ea04d4edbef..05676c5a623b1 100644
--- a/drivers/fpga/dfl/dfl-fme-main.c
+++ b/drivers/fpga/dfl/fme-main.c
@@ -22,7 +22,7 @@
 #include <linux/fpga-dfl.h>
 
 #include "dfl.h"
-#include "dfl-fme.h"
+#include "fme.h"
 
 static ssize_t ports_num_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
diff --git a/drivers/fpga/dfl/dfl-fme-mgr.c b/drivers/fpga/dfl/fme-mgr.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-fme-mgr.c
rename to drivers/fpga/dfl/fme-mgr.c
index d5861d13b3069..ae2b45abbe3aa 100644
--- a/drivers/fpga/dfl/dfl-fme-mgr.c
+++ b/drivers/fpga/dfl/fme-mgr.c
@@ -22,7 +22,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/fpga/fpga-mgr.h>
 
-#include "dfl-fme-pr.h"
+#include "fme-pr.h"
 
 /* FME Partial Reconfiguration Sub Feature Register Set */
 #define FME_PR_DFH		0x0
diff --git a/drivers/fpga/dfl/dfl-fme-perf.c b/drivers/fpga/dfl/fme-perf.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-fme-perf.c
rename to drivers/fpga/dfl/fme-perf.c
index 4299145ef347e..451d7b6e0ac1f 100644
--- a/drivers/fpga/dfl/dfl-fme-perf.c
+++ b/drivers/fpga/dfl/fme-perf.c
@@ -18,7 +18,7 @@
 
 #include <linux/perf_event.h>
 #include "dfl.h"
-#include "dfl-fme.h"
+#include "fme.h"
 
 /*
  * Performance Counter Registers for Cache.
diff --git a/drivers/fpga/dfl/dfl-fme-pr.c b/drivers/fpga/dfl/fme-pr.c
similarity index 99%
rename from drivers/fpga/dfl/dfl-fme-pr.c
rename to drivers/fpga/dfl/fme-pr.c
index d61ce9a188792..aed4f061c0bf2 100644
--- a/drivers/fpga/dfl/dfl-fme-pr.c
+++ b/drivers/fpga/dfl/fme-pr.c
@@ -26,8 +26,8 @@
 #include <linux/fpga-dfl.h>
 
 #include "dfl.h"
-#include "dfl-fme.h"
-#include "dfl-fme-pr.h"
+#include "fme.h"
+#include "fme-pr.h"
 
 static struct dfl_fme_region *
 dfl_fme_region_find_by_port_id(struct dfl_fme *fme, int port_id)
diff --git a/drivers/fpga/dfl/dfl-fme-pr.h b/drivers/fpga/dfl/fme-pr.h
similarity index 96%
rename from drivers/fpga/dfl/dfl-fme-pr.h
rename to drivers/fpga/dfl/fme-pr.h
index 096a699089d30..65b33cdeaf80d 100644
--- a/drivers/fpga/dfl/dfl-fme-pr.h
+++ b/drivers/fpga/dfl/fme-pr.h
@@ -15,8 +15,8 @@
  *   Henry Mitchel <henry.mitchel@intel.com>
  */
 
-#ifndef __DFL_FME_PR_H
-#define __DFL_FME_PR_H
+#ifndef __FME_PR_H
+#define __FME_PR_H
 
 #include <linux/platform_device.h>
 
@@ -81,4 +81,4 @@ struct dfl_fme_mgr_pdata {
 #define DFL_FPGA_FME_BRIDGE	"dfl-fme-bridge"
 #define DFL_FPGA_FME_REGION	"dfl-fme-region"
 
-#endif /* __DFL_FME_PR_H */
+#endif /* __FME_PR_H */
diff --git a/drivers/fpga/dfl/dfl-fme-region.c b/drivers/fpga/dfl/fme-region.c
similarity index 98%
rename from drivers/fpga/dfl/dfl-fme-region.c
rename to drivers/fpga/dfl/fme-region.c
index 1eeb42af10122..412609ebad148 100644
--- a/drivers/fpga/dfl/dfl-fme-region.c
+++ b/drivers/fpga/dfl/fme-region.c
@@ -17,7 +17,7 @@
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
 
-#include "dfl-fme-pr.h"
+#include "fme-pr.h"
 
 static int fme_region_get_bridges(struct fpga_region *region)
 {
diff --git a/drivers/fpga/dfl/dfl-fme.h b/drivers/fpga/dfl/fme.h
similarity index 95%
rename from drivers/fpga/dfl/dfl-fme.h
rename to drivers/fpga/dfl/fme.h
index 4195dd68193e7..300b6cc5cb63f 100644
--- a/drivers/fpga/dfl/dfl-fme.h
+++ b/drivers/fpga/dfl/fme.h
@@ -15,8 +15,8 @@
  *   Henry Mitchel <henry.mitchel@intel.com>
  */
 
-#ifndef __DFL_FME_H
-#define __DFL_FME_H
+#ifndef __FME_H
+#define __FME_H
 
 /**
  * struct dfl_fme - dfl fme private data
@@ -41,4 +41,4 @@ extern const struct attribute_group fme_global_err_group;
 extern const struct dfl_feature_ops fme_perf_ops;
 extern const struct dfl_feature_id fme_perf_id_table[];
 
-#endif /* __DFL_FME_H */
+#endif /* __FME_H */
diff --git a/drivers/fpga/dfl/dfl-n3000-nios.c b/drivers/fpga/dfl/n3000-nios.c
similarity index 100%
rename from drivers/fpga/dfl/dfl-n3000-nios.c
rename to drivers/fpga/dfl/n3000-nios.c
diff --git a/drivers/fpga/dfl/dfl-pci.c b/drivers/fpga/dfl/pci.c
similarity index 100%
rename from drivers/fpga/dfl/dfl-pci.c
rename to drivers/fpga/dfl/pci.c
-- 
2.26.3

