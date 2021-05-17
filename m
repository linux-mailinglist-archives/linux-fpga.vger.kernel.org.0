Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3588E3822CC
	for <lists+linux-fpga@lfdr.de>; Mon, 17 May 2021 04:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhEQCeR (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 16 May 2021 22:34:17 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:44609 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhEQCeR (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 16 May 2021 22:34:17 -0400
Received: by mail-pj1-f54.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so2845393pjb.3
        for <linux-fpga@vger.kernel.org>; Sun, 16 May 2021 19:33:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rKrrJk1MFKVUPavRvSfkhmOslcbkH8ouSxGsfIRu6kI=;
        b=c4blNG6nJ0ZRhKHN9WkQrWXQtaSHOmzFYDSCCLw4Lt/dhyqHpLF9XR1MZ5VtvA/3a+
         m+DPxWCANrBCSaXWdwb+vDYeL4bY/wVA7U+VrWV5d+H/tDz3hTpfKYM3aThc3mNA7Snq
         IWLSweKFN0rB+0WB3a4oeqWVU9ifsg02cMlbChi1xtzjK9JEocLCpd+h8Lp353QshgMF
         VsU+Ph93zB31H5ZnOfDK5ZL3DJNIINKn5VxSS/n6ccsJ/SRmFtIgPUx4mYpiedD75pBE
         ULXyX6zXaZoKOGuXuVM0/20UFqRy3VxlvV5gAZ4ubHeR2FV9LNMFvF1oxvvkZ5JWHRFR
         vBTw==
X-Gm-Message-State: AOAM533PobnDyNJeL4me37xvcZZyFfHJ29qyCoogJm6rN7XboCxfO3jW
        H9Yt92l2RHZSeVTVOLs4fi0=
X-Google-Smtp-Source: ABdhPJzk3MjWGXFbQyUOSIsO6rFtI3/0Wgdzbs4rO8MJVfF+DWnp4uhCBhguV7hARiTv5ftXpYpDBg==
X-Received: by 2002:a17:90a:6345:: with SMTP id v5mr24525780pjs.139.1621218780778;
        Sun, 16 May 2021 19:33:00 -0700 (PDT)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id v2sm8876321pfv.97.2021.05.16.19.33.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:33:00 -0700 (PDT)
From:   Moritz Fischer <mdf@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-fpga@vger.kernel.org, moritzf@google.com,
        Moritz Fischer <mdf@kernel.org>,
        Russ Weight <russell.h.weight@intel.com>,
        Tom Rix <trix@redhat.com>
Subject: [PATCH 10/12] fpga: m10bmc-sec: expose max10 canceled keys in sysfs
Date:   Sun, 16 May 2021 19:31:58 -0700
Message-Id: <20210517023200.52707-11-mdf@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210517023200.52707-1-mdf@kernel.org>
References: <20210517023200.52707-1-mdf@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From: Russ Weight <russell.h.weight@intel.com>

Extend the MAX10 BMC Secure Update driver to provide sysfs
files to expose the canceled code signing key (CSK) bit
vectors. These use the standard bitmap list format
(e.g. 1,2-6,9).

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Reviewed-by: Tom Rix <trix@redhat.com>
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
 .../testing/sysfs-driver-intel-m10-bmc-secure | 24 ++++++++++
 drivers/fpga/intel-m10-bmc-secure.c           | 48 +++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
index c805c25e776d..798d33b625d8 100644
--- a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
+++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc-secure
@@ -28,6 +28,30 @@ Description:	Read only. Returns the root entry hash for the BMC image
 		underlying device supports it.
 		Format: "0x%x".
 
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/sr_canceled_csks
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the static region. The standard bitmap
+		list format is used (e.g. "1,2-6,9").
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/pr_canceled_csks
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the partial reconfiguration region. The
+		standard bitmap list format is used (e.g. "1,2-6,9").
+
+What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/bmc_canceled_csks
+Date:		June 2021
+KernelVersion:	5.14
+Contact:	Russ Weight <russell.h.weight@intel.com>
+Description:	Read only. Returns a list of indices for canceled code
+		signing keys for the BMC.  The standard bitmap list format
+		is used (e.g. "1,2-6,9").
+
 What:		/sys/bus/platform/drivers/intel-m10bmc-secure/.../security/flash_count
 Date:		June 2021
 KernelVersion:	5.14
diff --git a/drivers/fpga/intel-m10-bmc-secure.c b/drivers/fpga/intel-m10-bmc-secure.c
index ecd63c13cb2d..87e16c146569 100644
--- a/drivers/fpga/intel-m10-bmc-secure.c
+++ b/drivers/fpga/intel-m10-bmc-secure.c
@@ -79,6 +79,51 @@ DEVICE_ATTR_SEC_REH_RO(bmc, BMC_PROG_MAGIC, BMC_PROG_ADDR, BMC_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(sr, SR_PROG_MAGIC, SR_PROG_ADDR, SR_REH_ADDR);
 DEVICE_ATTR_SEC_REH_RO(pr, PR_PROG_MAGIC, PR_PROG_ADDR, PR_REH_ADDR);
 
+#define CSK_BIT_LEN		128U
+#define CSK_32ARRAY_SIZE	DIV_ROUND_UP(CSK_BIT_LEN, 32)
+
+static ssize_t
+show_canceled_csk(struct device *dev, u32 addr, char *buf)
+{
+	unsigned int i, stride, size = CSK_32ARRAY_SIZE * sizeof(u32);
+	struct m10bmc_sec *sec = dev_get_drvdata(dev);
+	DECLARE_BITMAP(csk_map, CSK_BIT_LEN);
+	__le32 csk_le32[CSK_32ARRAY_SIZE];
+	u32 csk32[CSK_32ARRAY_SIZE];
+	int ret;
+
+	stride = regmap_get_reg_stride(sec->m10bmc->regmap);
+
+	WARN_ON(size % stride);
+	ret = regmap_bulk_read(sec->m10bmc->regmap, addr, csk_le32,
+			       size / stride);
+	if (ret) {
+		dev_err(sec->dev, "failed to read CSK vector: %x cnt %x: %d\n",
+			addr, size / stride, ret);
+		return ret;
+	}
+
+	for (i = 0; i < CSK_32ARRAY_SIZE; i++)
+		csk32[i] = le32_to_cpu(((csk_le32[i])));
+
+	bitmap_from_arr32(csk_map, csk32, CSK_BIT_LEN);
+	bitmap_complement(csk_map, csk_map, CSK_BIT_LEN);
+	return bitmap_print_to_pagebuf(1, buf, csk_map, CSK_BIT_LEN);
+}
+
+#define DEVICE_ATTR_SEC_CSK_RO(_name, _addr) \
+static ssize_t _name##_canceled_csks_show(struct device *dev, \
+					  struct device_attribute *attr, \
+					  char *buf) \
+{ return show_canceled_csk(dev, _addr, buf); } \
+static DEVICE_ATTR_RO(_name##_canceled_csks)
+
+#define CSK_VEC_OFFSET 0x34
+
+DEVICE_ATTR_SEC_CSK_RO(bmc, BMC_PROG_ADDR + CSK_VEC_OFFSET);
+DEVICE_ATTR_SEC_CSK_RO(sr, SR_PROG_ADDR + CSK_VEC_OFFSET);
+DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
+
 #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
 
 static ssize_t flash_count_show(struct device *dev,
@@ -119,6 +164,9 @@ static struct attribute *m10bmc_security_attrs[] = {
 	&dev_attr_bmc_root_entry_hash.attr,
 	&dev_attr_sr_root_entry_hash.attr,
 	&dev_attr_pr_root_entry_hash.attr,
+	&dev_attr_sr_canceled_csks.attr,
+	&dev_attr_pr_canceled_csks.attr,
+	&dev_attr_bmc_canceled_csks.attr,
 	NULL,
 };
 
-- 
2.31.1

