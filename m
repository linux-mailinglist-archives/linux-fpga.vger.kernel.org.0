Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B853822CB
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhEQCeP (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:15 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:44962 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhEQCeO (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:14 -0400
Received: by mail-pf1-f171.google.com with SMTP id 22so3558519pfv.11
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FUGSX1qCRIuUC6MduD9yhQ9xKVXDVKCIgoAMN8uhL2U=;
        b=EU7VTqOmrxP83IBEnqHIUf4d+ymL1hEn95wsMRcjyijTjFH3kZFYoYvG106AbibCYs
         ViVOtip838sf7UTdaJUAbLVGRPgnMPZcSC7lIkwmMNNLx7uQom1386S915sQYRUQx/fR
         KheImI5preR/dmlEGZOMn8nEZVX0TawIdpOiN5UjOUACBf9QZzClhd7XrpvsrojHIQlC
         dzrtxtSNylRB6a5rWVVANW96fhh2cc5Mp195GwSOQ1x5idfutH7ASLxkZDlWJcLFS2Cr
         W7aX+5X00Xpl6uuKHGs93c9dkkV+qQDVvY1DJKpaZ8oNiAqaz8QNHfr1bZRcTew0x7Ay
         AM2w==
X-Gm-Message-State: AOAM530KHzfWuj0jrUP6fPUth1Y6cNSZVGwWOznmC/o1OLbG+JuHXLbY
        yOWSE3h8nxyYp3z4QBZuZlw=
X-Google-Smtp-Source: ABdhPJxCnaQH7bqY3vvtu4Wrre0p7HdyspEfyca2we06PIY5AiL2nlyZTZTXS1ymxWgRTS7CP+FjWQ==
X-Received: by 2002:a65:640c:: with SMTP id a12mr58250232pgv.229.1621218779198;
        Sun, 16 May 2021 19:32:59 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id z3sm8327329pfe.78.2021.05.16.19.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:32:58 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 09/12] fpga: m10bmc-sec: expose max10 flash update count
Date:   Sun, 16 May 2021 19:31:57 -0700
Message-Id: <20210517023200.52707-10-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the MAX10 BMC Secure Update driver to provide a
sysfs file to expose the flash update count for the FPGA
user image.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../testing/sysfs-driver-intel-m10-bmc-secure |  8 ++++
 drivers/fpga/intel-m10-bmc-secure.c           | 37 +++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
index 9a0abb147b28..c805c25e776d 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -27,3 +27,11 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		"hash not programmed".  This file is only visible if the
 		underlying device supports it.
 		Format: "0x%x".
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/flash_count
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns number of times the secure update
+		staging area has been flashed.
+		Format: "%u".
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index 5ac5f59b5731..ecd63c13cb2d 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -11,6 +11,7 @@
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 
 struct m10bmc_sec {
 	struct device *dev;
@@ -78,7 +79,43 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
+
+static ssize_t flash_count_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	unsigned int stride, num_bits;
+	u8 *flash_buf;
+	int cnt, ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+	num_bits = FLASH_COUNT_SIZE * 8;
+
+	flash_buf = kmalloc(FLASH_COUNT_SIZE, GFP_KERNEL);
+	if (!flash_buf)
+		return -ENOMEM;
+
+	WARN_ON(FLASH_COUNT_SIZE % stride);
+	ret = regmap_bulk_read(sec->m10bmc->regmap, STAGING_FLASH_COUNT,
+			       flash_buf, FLASH_COUNT_SIZE / stride);
+	if (ret) {
+		dev_err(sec->dev,
+			"failed to read flash count: %x cnt %x: %d\n",
+			STAGING_FLASH_COUNT, FLASH_COUNT_SIZE / stride, ret);
+		goto exit_free;
+	}
+	cnt = num_bits - bitmap_weight((unsigned long *)flash_buf, num_bits);
+
+exit_free:
+	kfree(flash_buf);
+
+	return ret ? : sysfs_emit(buf, "%u\n", cnt);
+}
+static DEVICE_ATTR_RO(flash_count);
+
 static struct attribute *m10bmc_security_attrs[] = {
+	&dev_attr_flash_count.attr,
 	&dev_attr_bmc_root_entry_hash.attr,
 	&dev_attr_sr_root_entry_hash.attr,
 	&dev_attr_pr_root_entry_hash.attr,
-- 
2.31.1

