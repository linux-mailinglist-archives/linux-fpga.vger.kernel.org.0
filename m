Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D948380A97
	for <lists+linux-fpga@lfdr.de>; Sun,  4 Aug 2019 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfHDKiJ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 4 Aug 2019 06:38:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:31912 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726556AbfHDKiI (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 4 Aug 2019 06:38:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Aug 2019 03:38:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,345,1559545200"; 
   d="scan'208";a="167678993"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga008.jf.intel.com with ESMTP; 04 Aug 2019 03:38:05 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v4 10/12] fpga: dfl: fme: add capability sysfs interfaces
Date:   Sun,  4 Aug 2019 18:20:20 +0800
Message-Id: <1564914022-3710-11-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
References: <1564914022-3710-1-git-send-email-hao.wu@intel.com>
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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased.
v3: update kernel version and date in sysfs doc
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme | 23 ++++++++++++
 drivers/fpga/dfl-fme-main.c                      | 48 ++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 8fa4feb..65372aa 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -21,3 +21,26 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-only. It returns Bitstream (static FPGA region) meta
 		data, which includes the synthesis date, seed and other
 		information of this static FPGA region.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/cache_size
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns cache size of this FPGA device.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/fabric_version
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns fabric version of this FPGA device.
+		Userspace applications need this information to select
+		best data channels per different fabric design.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/socket_id
+Date:		August 2019
+KernelVersion:  5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns socket_id to indicate which socket
+		this FPGA belongs to, only valid for integrated solution.
+		User only needs this information, in case standard numa node
+		can't provide correct information.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 5fdce54..f033f1c 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -73,10 +73,58 @@ static ssize_t bitstream_metadata_show(struct device *dev,
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
 static struct attribute *fme_hdr_attrs[] = {
 	&dev_attr_ports_num.attr,
 	&dev_attr_bitstream_id.attr,
 	&dev_attr_bitstream_metadata.attr,
+	&dev_attr_cache_size.attr,
+	&dev_attr_fabric_version.attr,
+	&dev_attr_socket_id.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(fme_hdr);
-- 
1.8.3.1

