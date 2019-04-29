Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A04FDF00
	for <lists+linux-fpga@lfdr.de>; Mon, 29 Apr 2019 11:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfD2JMw (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 29 Apr 2019 05:12:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:32630 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727895AbfD2JMu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 29 Apr 2019 05:12:50 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Apr 2019 02:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,409,1549958400"; 
   d="scan'208";a="165988245"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2019 02:12:48 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v2 08/18] fpga: dfl: afu: add AFU state related sysfs interfaces
Date:   Mon, 29 Apr 2019 16:55:41 +0800
Message-Id: <1556528151-17221-9-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch introduces more sysfs interfaces for Accelerated
Function Unit (AFU). These interfaces allow users to read
current AFU Power State (APx), read / clear AFU Power (APx)
events which are sticky to identify transient APx state,
and manage AFU's LTR (latency tolerance reporting).

Signed-off-by: Ananda Ravuri <ananda.ravuri@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Alan Tull <atull@kernel.org>
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  30 +++++
 drivers/fpga/dfl-afu-main.c                       | 144 ++++++++++++++++++++++
 drivers/fpga/dfl.h                                |  11 ++
 3 files changed, 185 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index 6a92dda..d7122a4 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -14,3 +14,33 @@ Description:	Read-only. User can program different PR bitstreams to FPGA
 		Accelerator Function Unit (AFU) for different functions. It
 		returns uuid which could be used to identify which PR bitstream
 		is programmed in this AFU.
+
+What:		/sys/bus/platform/devices/dfl-port.0/power_state
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It reports the APx (AFU Power) state, different APx
+		means different throttling level. When reading this file, it
+		returns "0" - Normal / "1" - AP1 / "2" - AP2 / "6" - AP6.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ap1_event
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read or set 1 to clear AP1 (AFU Power State 1)
+		event. It's used to indicate transient AP1 state.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ap2_event
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read or set 1 to clear AP2 (AFU Power State 2)
+		event. It's used to indicate transient AP2 state.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ltr
+Date:		April 2019
+KernelVersion:	5.2
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read and set AFU latency tolerance reporting value.
+		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
+		to 0 if it is latency sensitive.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 02baa6a..2ffec06 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -21,6 +21,8 @@
 
 #include "dfl-afu.h"
 
+#define DRV_VERSION	"0.8"
+
 /**
  * port_enable - enable a port
  * @pdev: port platform device.
@@ -141,8 +143,149 @@ static int port_get_id(struct platform_device *pdev)
 }
 static DEVICE_ATTR_RO(id);
 
+static ssize_t
+ltr_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_CTRL);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n",
+			 (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
+}
+
+static ssize_t
+ltr_store(struct device *dev, struct device_attribute *attr,
+	  const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 ltr;
+	u64 v;
+
+	if (kstrtou8(buf, 0, &ltr) || ltr > 1)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_CTRL);
+	v &= ~PORT_CTRL_LATENCY;
+	v |= FIELD_PREP(PORT_CTRL_LATENCY, ltr);
+	writeq(v, base + PORT_HDR_CTRL);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(ltr);
+
+static ssize_t
+ap1_event_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n",
+			 (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
+}
+
+static ssize_t
+ap1_event_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 ap1_event;
+
+	if (kstrtou8(buf, 0, &ap1_event) || ap1_event != 1)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	writeq(PORT_STS_AP1_EVT, base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(ap1_event);
+
+static ssize_t
+ap2_event_show(struct device *dev, struct device_attribute *attr,
+	       char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "%x\n",
+			 (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
+}
+
+static ssize_t
+ap2_event_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t count)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u8 ap2_event;
+
+	if (kstrtou8(buf, 0, &ap2_event) || ap2_event != 1)
+		return -EINVAL;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	writeq(PORT_STS_AP2_EVT, base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return count;
+}
+static DEVICE_ATTR_RW(ap2_event);
+
+static ssize_t
+power_state_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev);
+	void __iomem *base;
+	u64 v;
+
+	base = dfl_get_feature_ioaddr_by_id(dev, PORT_FEATURE_ID_HEADER);
+
+	mutex_lock(&pdata->lock);
+	v = readq(base + PORT_HDR_STS);
+	mutex_unlock(&pdata->lock);
+
+	return scnprintf(buf, PAGE_SIZE, "0x%x\n",
+			 (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
+}
+static DEVICE_ATTR_RO(power_state);
+
 static const struct attribute *port_hdr_attrs[] = {
 	&dev_attr_id.attr,
+	&dev_attr_ltr.attr,
+	&dev_attr_ap1_event.attr,
+	&dev_attr_ap2_event.attr,
+	&dev_attr_power_state.attr,
 	NULL,
 };
 
@@ -634,3 +777,4 @@ static void __exit afu_exit(void)
 MODULE_AUTHOR("Intel Corporation");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:dfl-port");
+MODULE_VERSION(DRV_VERSION);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 1350e8e..1525098 100644
--- a/drivers/fpga/dfl.h
+++ b/drivers/fpga/dfl.h
@@ -119,6 +119,7 @@
 #define PORT_HDR_NEXT_AFU	NEXT_AFU
 #define PORT_HDR_CAP		0x30
 #define PORT_HDR_CTRL		0x38
+#define PORT_HDR_STS		0x40
 
 /* Port Capability Register Bitfield */
 #define PORT_CAP_PORT_NUM	GENMASK_ULL(1, 0)	/* ID of this port */
@@ -130,6 +131,16 @@
 /* Latency tolerance reporting. '1' >= 40us, '0' < 40us.*/
 #define PORT_CTRL_LATENCY	BIT_ULL(2)
 #define PORT_CTRL_SFTRST_ACK	BIT_ULL(4)		/* HW ack for reset */
+
+/* Port Status Register Bitfield */
+#define PORT_STS_AP2_EVT	BIT_ULL(13)		/* AP2 event detected */
+#define PORT_STS_AP1_EVT	BIT_ULL(12)		/* AP1 event detected */
+#define PORT_STS_PWR_STATE	GENMASK_ULL(11, 8)	/* AFU power states */
+#define PORT_STS_PWR_STATE_NORM 0
+#define PORT_STS_PWR_STATE_AP1	1			/* 50% throttling */
+#define PORT_STS_PWR_STATE_AP2	2			/* 90% throttling */
+#define PORT_STS_PWR_STATE_AP6	6			/* 100% throttling */
+
 /**
  * struct dfl_fpga_port_ops - port ops
  *
-- 
1.8.3.1

