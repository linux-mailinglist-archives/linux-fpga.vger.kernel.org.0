Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2A8710DA
	for <lists+linux-fpga@lfdr.de>; Tue, 23 Jul 2019 07:10:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732817AbfGWFKI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Jul 2019 01:10:08 -0400
Received: from mga05.intel.com ([192.55.52.43]:1853 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732800AbfGWFKE (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 23 Jul 2019 01:10:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Jul 2019 22:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,297,1559545200"; 
   d="scan'208";a="196992335"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2019 22:10:01 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     gregkh@linuxfoundation.org, mdf@kernel.org,
        linux-fpga@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, atull@kernel.org,
        Wu Hao <hao.wu@intel.com>,
        Ananda Ravuri <ananda.ravuri@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v3 04/12] fpga: dfl: afu: add AFU state related sysfs interfaces
Date:   Tue, 23 Jul 2019 12:51:27 +0800
Message-Id: <1563857495-26692-5-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
References: <1563857495-26692-1-git-send-email-hao.wu@intel.com>
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
Signed-off-by: Moritz Fischer <mdf@kernel.org>
---
v2: rebased, and remove DRV/MODULE_VERSION modifications
v3: update kernel version and date in sysfs doc
---
 Documentation/ABI/testing/sysfs-platform-dfl-port |  30 +++++
 drivers/fpga/dfl-afu-main.c                       | 137 ++++++++++++++++++++++
 drivers/fpga/dfl.h                                |  11 ++
 3 files changed, 178 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-port b/Documentation/ABI/testing/sysfs-platform-dfl-port
index 6a92dda..5961fb2 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-port
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-port
@@ -14,3 +14,33 @@ Description:	Read-only. User can program different PR bitstreams to FPGA
 		Accelerator Function Unit (AFU) for different functions. It
 		returns uuid which could be used to identify which PR bitstream
 		is programmed in this AFU.
+
+What:		/sys/bus/platform/devices/dfl-port.0/power_state
+Date:		July 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It reports the APx (AFU Power) state, different APx
+		means different throttling level. When reading this file, it
+		returns "0" - Normal / "1" - AP1 / "2" - AP2 / "6" - AP6.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ap1_event
+Date:		July 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read or set 1 to clear AP1 (AFU Power State 1)
+		event. It's used to indicate transient AP1 state.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ap2_event
+Date:		July 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read or set 1 to clear AP2 (AFU Power State 2)
+		event. It's used to indicate transient AP2 state.
+
+What:		/sys/bus/platform/devices/dfl-port.0/ltr
+Date:		July 2019
+KernelVersion:	5.4
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-write. Read and set AFU latency tolerance reporting value.
+		Set ltr to 1 if the AFU can tolerate latency >= 40us or set it
+		to 0 if it is latency sensitive.
diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 68b4d08..cb3f73e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -141,8 +141,145 @@ static int port_get_id(struct platform_device *pdev)
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
+	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_CTRL_LATENCY, v));
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
+	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP1_EVT, v));
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
+	return sprintf(buf, "%x\n", (u8)FIELD_GET(PORT_STS_AP2_EVT, v));
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
+	return sprintf(buf, "0x%x\n", (u8)FIELD_GET(PORT_STS_PWR_STATE, v));
+}
+static DEVICE_ATTR_RO(power_state);
+
 static struct attribute *port_hdr_attrs[] = {
 	&dev_attr_id.attr,
+	&dev_attr_ltr.attr,
+	&dev_attr_ap1_event.attr,
+	&dev_attr_ap2_event.attr,
+	&dev_attr_power_state.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(port_hdr);
diff --git a/drivers/fpga/dfl.h b/drivers/fpga/dfl.h
index 061ccd4..fe7bca4 100644
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

