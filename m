Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C09CDF07
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Apr 2019 11:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfD2JNo (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Apr 2019 05:13:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:32630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbfD2JMw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Apr 2019 05:12:52 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 02:12:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="165988254"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2019 02:12:50 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 09/18] fpga: dfl: afu: add userclock sysfs interfaces.
Date:   Mon, 29 Apr 2019 16:55:42 +0800
Message-Id: <1556528151-17221-10-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
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
 Documentation/ABI/testing/sysfs-platform-dfl-port |  35 +++++++
 drivers/fpga/dfl-afu-main.c                       | 114 +++++++++++++++++++++-
 drivers/fpga/dfl.h                                |   4 +
 3 files changed, 152 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index d7122a4..71f4892 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -44,3 +44,38 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-write. Read and set AFU latency tolerance reporting value.
 		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
 		to 0 if it is latency sensitive.
+
+What:		/sys/bus/platform/devices/dfl-port.0/revision
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the revision of port header
+		feature.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcmd
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. User writes command to this interface to set
+		userclock to AFU.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqsts
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the status of issued command
+		to userclck_freqcmd.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrcmd
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. User writes command to this interface to set
+		userclock counter.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrsts
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the status of issued command
+		to userclck_freqcntrcmd.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 2ffec06..82fd80a 100644
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
+	return scnprintf(buf, PAGE_SIZE, "%x\n", dfl_feature_revision(base));
+}
+static DEVICE_ATTR_RO(revision);
+
+static ssize_t
 ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
@@ -282,6 +293,7 @@ static int port_get_id(struct platform_device *pdev)
 
 static const struct attribute *port_hdr_attrs[] = {
 	&dev_attr_id.attr,
+	&dev_attr_revision.attr,
 	&dev_attr_ltr.attr,
 	&dev_attr_ap1_event.attr,
 	&dev_attr_ap2_event.attr,
@@ -289,14 +301,113 @@ static int port_get_id(struct platform_device *pdev)
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
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n",
+			 (unsigned long long)userclk_freqsts);
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
+	return scnprintf(buf, PAGE_SIZE, "0x%llx\n",
+			 (unsigned long long)userclk_freqcntrsts);
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
@@ -304,6 +415,7 @@ static void port_hdr_uinit(struct platform_device *pdev,
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

