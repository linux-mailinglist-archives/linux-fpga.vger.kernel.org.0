Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 534B82AE21
	for <lists+linux-fpga@lfdr.de>; Mon, 27 May 2019 07:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfE0FjO (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 27 May 2019 01:39:14 -0400
Received: from mga04.intel.com ([192.55.52.120]:7420 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfE0FjN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 27 May 2019 01:39:13 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 May 2019 22:39:13 -0700
X-ExtLoop1: 1
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga001.jf.intel.com with ESMTP; 26 May 2019 22:39:11 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 09/16] fpga: dfl: afu: add userclock sysfs interfaces.
Date:   Mon, 27 May 2019 13:22:19 +0800
Message-Id: <1558934546-12171-10-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
References: <1558934546-12171-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch introduces userclock sysfs interfaces for AFU, user
could use these interfaces for clock setting to AFU.

Please note that, this is only working for port header feature
with revision 0, for later revisions, userclock setting is moved
to a separated private feature, so one revision sysfs interface
is exposed to userspace application for this purpose too.

Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: replace scnprintf with sprintf in sysfs interfaces.
    update sysfs doc kernel version and date.
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  35 +++++++
 drivers/fpga/dfl-afu-main.c                       | 113 +++++++++++++++++++++-
 drivers/fpga/dfl.h                                |   4 +
 3 files changed, 151 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index c11c6c6..f5f746d 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -44,3 +44,38 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-write. Read and set AFU latency tolerance reporting value.
 		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
 		to 0 if it is latency sensitive.
+
+What:		/sys/bus/platform/devices/dfl-port.0/revision
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the revision of port header
+		feature.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcmd
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. User writes command to this interface to set
+		userclock to AFU.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqsts
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the status of issued command
+		to userclck_freqcmd.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrcmd
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. User writes command to this interface to set
+		userclock counter.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrsts
+Date:		May 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the status of issued command
+		to userclck_freqcntrcmd.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 040ed8a..8b434a4 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -144,6 +144,17 @@ static int port_get_id(struct platform_device *pdev)
 static DEVICE_ATTR_RO(id);
 
 static ssize_t
+revision_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	return sprintf(buf, "%x\n", dfl_feature_revision(base));
+}
+static DEVICE_ATTR_RO(revision);
+
+static ssize_t
 ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
@@ -278,6 +289,7 @@ static int port_get_id(struct platform_device *pdev)
 
 static const struct attribute *port_hdr_attrs[] = {
 	&dev_attr_id.attr,
+	&dev_attr_revision.attr,
 	&dev_attr_ltr.attr,
 	&dev_attr_ap1_event.attr,
 	&dev_attr_ap2_event.attr,
@@ -285,14 +297,112 @@ static int port_get_id(struct platform_device *pdev)
 	NULL,
 };
 
+static ssize_t
+userclk_freqcmd_store(struct device *dev, struct device_attribute *attr,
+		      const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	u64 userclk_freq_cmd;
+	void __iomem *base;
+
+	if (kstrtou64(buf, 0, &userclk_freq_cmd))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	writeq(userclk_freq_cmd, base + PORT_HDR_USRCLK_CMD0);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_WO(userclk_freqcmd);
+
+static ssize_t
+userclk_freqcntrcmd_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	u64 userclk_freqcntr_cmd;
+	void __iomem *base;
+
+	if (kstrtou64(buf, 0, &userclk_freqcntr_cmd))
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	writeq(userclk_freqcntr_cmd, base + PORT_HDR_USRCLK_CMD1);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_WO(userclk_freqcntrcmd);
+
+static ssize_t
+userclk_freqsts_show(struct device *dev, struct device_attribute *attr,
+		     char *buf)
+{
+	u64 userclk_freqsts;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
+}
+static DEVICE_ATTR_RO(userclk_freqsts);
+
+static ssize_t
+userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	u64 userclk_freqcntrsts;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)userclk_freqcntrsts);
+}
+static DEVICE_ATTR_RO(userclk_freqcntrsts);
+
+static const struct attribute *port_hdr_userclk_attrs[] = {
+	&dev_attr_userclk_freqcmd.attr,
+	&dev_attr_userclk_freqcntrcmd.attr,
+	&dev_attr_userclk_freqsts.attr,
+	&dev_attr_userclk_freqcntrsts.attr,
+	NULL,
+};
+
 static int port_hdr_init(struct platform_device *pdev,
 			 struct dfl_feature *feature)
 {
+	int ret;
+
 	dev_dbg(&pdev->dev, "PORT HDR Init.\n");
 
 	port_reset(pdev);
 
-	return sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
+	ret = sysfs_create_files(&pdev->dev.kobj, port_hdr_attrs);
+	if (ret)
+		return ret;
+
+	/*
+	 * if revision > 0, the userclock will be moved from port hdr register
+	 * region to a separated private feature.
+	 */
+	if (dfl_feature_revision(feature->ioaddr) > 0)
+		return 0;
+
+	ret = sysfs_create_files(&pdev->dev.kobj, port_hdr_userclk_attrs);
+	if (ret)
+		sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
+
+	return ret;
 }
 
 static void port_hdr_uinit(struct platform_device *pdev,
@@ -300,6 +410,7 @@ static void port_hdr_uinit(struct platform_device *pdev,
 {
 	dev_dbg(&pdev->dev, "PORT HDR UInit.\n");
 
+	sysfs_remove_files(&pdev->dev.kobj, port_hdr_userclk_attrs);
 	sysfs_remove_files(&pdev->dev.kobj, port_hdr_attrs);
 }
 
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 1525098..3c5dc3a 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -120,6 +120,10 @@
 #define PORT_HDR_CAP		0x30
 #define PORT_HDR_CTRL		0x38
 #define PORT_HDR_STS		0x40
+#define PORT_HDR_USRCLK_CMD0	0x50
+#define PORT_HDR_USRCLK_CMD1	0x58
+#define PORT_HDR_USRCLK_STS0	0x60
+#define PORT_HDR_USRCLK_STS1	0x68
 
 /* Port Capability Register Bitfield */
 #define PORT_CAP_PORT_NUM	GENMASK_ULL(1, 0)	/* ID of this port */
-- 
1.8.3.1

