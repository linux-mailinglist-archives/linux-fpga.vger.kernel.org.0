Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD33895A5
	for <lists+linux-fpga@lfdr.de>; Mon, 12 Aug 2019 05:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfHLDH4 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 11 Aug 2019 23:07:56 -0400
Received: from mga17.intel.com ([192.55.52.151]:12631 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726750AbfHLDHy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 11 Aug 2019 23:07:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2019 20:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,375,1559545200"; 
   d="scan'208";a="199987483"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2019 20:07:52 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v5 4/9] fpga: dfl: afu: add userclock sysfs interfaces.
Date:   Mon, 12 Aug 2019 10:49:59 +0800
Message-Id: <1565578204-13969-5-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
References: <1565578204-13969-1-git-send-email-hao.wu@intel.com>
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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased, and switched to use device_add/remove_groups for sysfs
v3: update kernel version and date in sysfs doc
v4: rebased.
v5: drop sysfs add/remove in init/uinit callback.
    add missed locking for sysfs.
    use is_visible to decide if hardware supports userclk or not.
    remove revision sysfs entry.
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  28 ++++++
 drivers/fpga/dfl-afu-main.c                       | 111 +++++++++++++++++++++-
 drivers/fpga/dfl.h                                |   9 ++
 3 files changed, 147 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index 1ab3e6f..c2660e4 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -46,3 +46,31 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-write. Read or set AFU latency tolerance reporting value.
 		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
 		to 0 if it is latency sensitive.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcmd
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. User writes command to this interface to set
+		userclock to AFU.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqsts
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the status of issued command
+		to userclck_freqcmd.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrcmd
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Write-only. User writes command to this interface to set
+		userclock counter.
+
+What:		/sys/bus/platform/devices/dfl-port.0/userclk_freqcntrsts
+Date:		August 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get the status of issued command
+		to userclck_freqcntrcmd.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index e955149..f0b45f2 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -274,17 +274,126 @@ static int port_get_id(struct platform_device *pdev)
 }
 static DEVICE_ATTR_RO(power_state);
 
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
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	u64 userclk_freqsts;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	userclk_freqsts = readq(base + PORT_HDR_USRCLK_STS0);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n", (unsigned long long)userclk_freqsts);
+}
+static DEVICE_ATTR_RO(userclk_freqsts);
+
+static ssize_t
+userclk_freqcntrsts_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	u64 userclk_freqcntrsts;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	userclk_freqcntrsts = readq(base + PORT_HDR_USRCLK_STS1);
+	mutex_unlock(&pdata->lock);
+
+	return sprintf(buf, "0x%llx\n",
+		       (unsigned long long)userclk_freqcntrsts);
+}
+static DEVICE_ATTR_RO(userclk_freqcntrsts);
+
 static struct attribute *port_hdr_attrs[] = {
 	&dev_attr_id.attr,
 	&dev_attr_ltr.attr,
 	&dev_attr_ap1_event.attr,
 	&dev_attr_ap2_event.attr,
 	&dev_attr_power_state.attr,
+	&dev_attr_userclk_freqcmd.attr,
+	&dev_attr_userclk_freqcntrcmd.attr,
+	&dev_attr_userclk_freqsts.attr,
+	&dev_attr_userclk_freqcntrsts.attr,
 	NULL,
 };
 
+static umode_t port_hdr_attrs_visible(struct kobject *kobj,
+				      struct attribute *attr, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	umode_t mode = attr->mode;
+	void __iomem *base;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	if (dfl_feature_revision(base) > 0) {
+		/*
+		 * userclk sysfs interfaces are only visible in case port
+		 * revision is 0, as hardware with revision >0 doesn't
+		 * support this.
+		 */
+		if (attr == &dev_attr_userclk_freqcmd.attr ||
+		    attr == &dev_attr_userclk_freqcntrcmd.attr ||
+		    attr == &dev_attr_userclk_freqsts.attr ||
+		    attr == &dev_attr_userclk_freqcntrsts.attr)
+			mode = 0;
+	}
+
+	return mode;
+}
+
 static const struct attribute_group port_hdr_group = {
-	.attrs = port_hdr_attrs,
+	.attrs      = port_hdr_attrs,
+	.is_visible = port_hdr_attrs_visible,
 };
 
 static int port_hdr_init(struct platform_device *pdev,
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 856ea4e..9f0e656 100644
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
@@ -355,6 +359,11 @@ static inline bool dfl_feature_is_port(void __iomem *base)
 		(FIELD_GET(DFH_ID, v) == DFH_ID_FIU_PORT);
 }
 
+static inline u8 dfl_feature_revision(void __iomem *base)
+{
+	return (u8)FIELD_GET(DFH_REVISION, readq(base + DFH));
+}
+
 /**
  * struct dfl_fpga_enum_info - DFL FPGA enumeration information
  *
-- 
1.8.3.1

