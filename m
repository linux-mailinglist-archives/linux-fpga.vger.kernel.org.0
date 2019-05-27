Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC52D2AE1D
	for <lists+linux-fpga@lfdr.de>; Mon, 27 May 2019 07:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbfE0FjX (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 01:39:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:7420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726553AbfE0FjW (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 May 2019 01:39:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 22:39:22 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2019 22:39:20 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 14/16] fpga: dfl: fme: add capability sysfs interfaces
Date:   Mon, 27 May 2019 13:22:24 +0800
Message-Id: <1558934546-12171-15-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds 3 read-only sysfs interfaces for FPGA Management Engine
(FME) block for capabilities including cache_size, fabric_version and
socket_id.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: replace scnprintf with sprintf in sysfs interfaces.
    update sysfs doc kernel version and date.
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme | 23 ++++++++++++
 drivers/fpga/dfl-fme-main.c                      | 48 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 8fa4feb..d65f2c3 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -21,3 +21,26 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. It returns Bitstream (static FPGA region) meta
 		data, which includes the synthesis date, seed and other
 		information of this static FPGA region.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/cache_size
+Date:		May 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns cache size of this FPGA device.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/fabric_version
+Date:		May 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns fabric version of this FPGA device.
+		Userspace applications need this information to select
+		best data channels per different fabric design.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/socket_id
+Date:		May 2019
+KernelVersion:  5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns socket_id to indicate which socket
+		this FPGA belongs to, only valid for integrated solution.
+		User only needs this information, in case standard numa node
+		can't provide correct information.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 38c6342..2d69b8f 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -75,10 +75,58 @@ static ssize_t bitstream_metadata_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(bitstream_metadata);
 
+static ssize_t cache_size_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_CAP_CACHE_SIZE, v));
+}
+static DEVICE_ATTR_RO(cache_size);
+
+static ssize_t fabric_version_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_CAP_FABRIC_VERID, v));
+}
+static DEVICE_ATTR_RO(fabric_version);
+
+static ssize_t socket_id_show(struct device *dev,
+			      struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, FME_FEATURE_ID_HEADER);
+
+	v = readq(base + FME_HDR_CAP);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_CAP_SOCKET_ID, v));
+}
+static DEVICE_ATTR_RO(socket_id);
+
 static const struct attribute *fme_hdr_attrs[] = {
 	&dev_attr_ports_num.attr,
 	&dev_attr_bitstream_id.attr,
 	&dev_attr_bitstream_metadata.attr,
+	&dev_attr_cache_size.attr,
+	&dev_attr_fabric_version.attr,
+	&dev_attr_socket_id.attr,
 	NULL,
 };
 
-- 
1.8.3.1

