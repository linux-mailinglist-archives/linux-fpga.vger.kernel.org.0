Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E23557B2D
	for <lists+linux-fpga@lfdr.de>; Thu, 27 Jun 2019 07:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727353AbfF0FKp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 Jun 2019 01:10:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:23286 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725385AbfF0FKn (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 Jun 2019 01:10:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2019 22:10:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,422,1557212400"; 
   d="scan'208";a="313672766"
Received: from hao-dev.bj.intel.com ([10.238.157.65])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2019 22:10:40 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net, atull@kernel.org,
        gregkh@linuxfoundation.org, Wu Hao <hao.wu@intel.com>,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: [PATCH v4 3/3] fpga: dfl: fme: add power management support
Date:   Thu, 27 Jun 2019 12:53:38 +0800
Message-Id: <1561611218-5800-4-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561611218-5800-1-git-send-email-hao.wu@intel.com>
References: <1561611218-5800-1-git-send-email-hao.wu@intel.com>
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support for power management private feature under
FPGA Management Engine (FME). This private feature driver registers
a hwmon for power (power1_input), thresholds information, e.g.
(power1_max / crit / max_alarm / crit_alarm) and also read-only sysfs
interfaces for other power management information. For configuration,
user could write threshold values via above power1_max / crit sysfs
interface under hwmon too.

Signed-off-by: Luwei Kang <luwei.kang@intel.com>
Signed-off-by: Xu Yilun <yilun.xu@intel.com>
Signed-off-by: Wu Hao <hao.wu@intel.com>
---
v2: create a dfl_fme_power hwmon to expose power sysfs interfaces.
    move all sysfs interfaces under hwmon
        consumed          --> hwmon power1_input
        threshold1        --> hwmon power1_cap
        threshold2        --> hwmon power1_crit
        threshold1_status --> hwmon power1_cap_status
        threshold2_status --> hwmon power1_crit_status
        xeon_limit        --> hwmon power1_xeon_limit
        fpga_limit        --> hwmon power1_fpga_limit
        ltr               --> hwmon power1_ltr
v3: rename some hwmon sysfs interfaces to follow hwmon ABI.
	power1_cap         --> power1_max
	power1_cap_status  --> power1_max_alarm
	power1_crit_status --> power1_crit_alarm
    update sysfs doc for above sysfs interface changes.
    replace scnprintf with sprintf in sysfs interface.
v4: use HWMON_CHANNEL_INFO.
    update date in sysfs doc.
---
 Documentation/ABI/testing/sysfs-platform-dfl-fme |  67 +++++++
 drivers/fpga/dfl-fme-main.c                      | 221 +++++++++++++++++++++++
 2 files changed, 288 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
index 2cd17dc..a669548 100644
--- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
+++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
@@ -127,6 +127,7 @@ Contact:	Wu Hao <hao.wu@intel.com>
 Description:	Read-Only. Read this file to get the name of hwmon device, it
 		supports values:
 		    'dfl_fme_thermal' - thermal hwmon device name
+		    'dfl_fme_power'   - power hwmon device name
 
 What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
 Date:		June 2019
@@ -183,3 +184,69 @@ Description:	Read-Only. Read this file to get the policy of hardware threshold1
 		(see 'temp1_max'). It only supports two values (policies):
 		    0 - AP2 state (90% throttling)
 		    1 - AP1 state (50% throttling)
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_input
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns current FPGA power consumption in uW.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_max
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to get current hardware power
+		threshold1 in uW. If power consumption rises at or above
+		this threshold, hardware starts 50% throttling.
+		Write this file to set current hardware power threshold1 in uW.
+		As hardware only accepts values in Watts, so input value will
+		be round down per Watts (< 1 watts part will be discarded).
+		Write fails with -EINVAL if input parsing fails or input isn't
+		in the valid range (0 - 127000000 uW).
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_crit
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Write. Read this file to get current hardware power
+		threshold2 in uW. If power consumption rises at or above
+		this threshold, hardware starts 90% throttling.
+		Write this file to set current hardware power threshold2 in uW.
+		As hardware only accepts values in Watts, so input value will
+		be round down per Watts (< 1 watts part will be discarded).
+		Write fails with -EINVAL if input parsing fails or input isn't
+		in the valid range (0 - 127000000 uW).
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_max_alarm
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns 1 if power consumption is currently at or
+		above hardware threshold1 (see 'power1_max'), otherwise 0.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_crit_alarm
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. It returns 1 if power consumption is currently at or
+		above hardware threshold2 (see 'power1_crit'), otherwise 0.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_xeon_limit
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns power limit for XEON in uW.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_fpga_limit
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-Only. It returns power limit for FPGA in uW.
+
+What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_ltr
+Date:		June 2019
+KernelVersion:	5.3
+Contact:	Wu Hao <hao.wu@intel.com>
+Description:	Read-only. Read this file to get current Latency Tolerance
+		Reporting (ltr) value. This ltr impacts the CPU low power
+		state in integrated solution.
diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
index 59ff9f1..9225b68 100644
--- a/drivers/fpga/dfl-fme-main.c
+++ b/drivers/fpga/dfl-fme-main.c
@@ -400,6 +400,223 @@ static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
 	.uinit = fme_thermal_mgmt_uinit,
 };
 
+#define FME_PWR_STATUS		0x8
+#define FME_LATENCY_TOLERANCE	BIT_ULL(18)
+#define PWR_CONSUMED		GENMASK_ULL(17, 0)
+
+#define FME_PWR_THRESHOLD	0x10
+#define PWR_THRESHOLD1		GENMASK_ULL(6, 0)	/* in Watts */
+#define PWR_THRESHOLD2		GENMASK_ULL(14, 8)	/* in Watts */
+#define PWR_THRESHOLD_MAX	0x7f			/* in Watts */
+#define PWR_THRESHOLD1_STATUS	BIT_ULL(16)
+#define PWR_THRESHOLD2_STATUS	BIT_ULL(17)
+
+#define FME_PWR_XEON_LIMIT	0x18
+#define XEON_PWR_LIMIT		GENMASK_ULL(14, 0)	/* in 0.1 Watts */
+#define XEON_PWR_EN		BIT_ULL(15)
+#define FME_PWR_FPGA_LIMIT	0x20
+#define FPGA_PWR_LIMIT		GENMASK_ULL(14, 0)	/* in 0.1 Watts */
+#define FPGA_PWR_EN		BIT_ULL(15)
+
+#define PWR_THRESHOLD_MAX_IN_UW (PWR_THRESHOLD_MAX * 1000000)
+
+static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long *val)
+{
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	u64 v;
+
+	switch (attr) {
+	case hwmon_power_input:
+		v = readq(feature->ioaddr + FME_PWR_STATUS);
+		*val = (long)(FIELD_GET(PWR_CONSUMED, v) * 1000000);
+		break;
+	case hwmon_power_max:
+		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
+		*val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * 1000000);
+		break;
+	case hwmon_power_crit:
+		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
+		*val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * 1000000);
+		break;
+	case hwmon_power_max_alarm:
+		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
+		*val = (long)FIELD_GET(PWR_THRESHOLD1_STATUS, v);
+		break;
+	case hwmon_power_crit_alarm:
+		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
+		*val = (long)FIELD_GET(PWR_THRESHOLD2_STATUS, v);
+		break;
+	default:
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			     u32 attr, int channel, long val)
+{
+	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	int ret = 0;
+	u64 v;
+
+	if (val < 0 || val > PWR_THRESHOLD_MAX_IN_UW)
+		return -EINVAL;
+
+	val = val / 1000000;
+
+	mutex_lock(&pdata->lock);
+
+	switch (attr) {
+	case hwmon_power_max:
+		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
+		v &= ~PWR_THRESHOLD1;
+		v |= FIELD_PREP(PWR_THRESHOLD1, val);
+		writeq(v, feature->ioaddr + FME_PWR_THRESHOLD);
+		break;
+	case hwmon_power_crit:
+		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
+		v &= ~PWR_THRESHOLD2;
+		v |= FIELD_PREP(PWR_THRESHOLD2, val);
+		writeq(v, feature->ioaddr + FME_PWR_THRESHOLD);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}
+
+	mutex_unlock(&pdata->lock);
+
+	return ret;
+}
+
+static umode_t power_hwmon_attrs_visible(const void *drvdata,
+					 enum hwmon_sensor_types type,
+					 u32 attr, int channel)
+{
+	switch (attr) {
+	case hwmon_power_input:
+	case hwmon_power_max_alarm:
+	case hwmon_power_crit_alarm:
+		return 0444;
+	case hwmon_power_max:
+	case hwmon_power_crit:
+		return 0644;
+	}
+
+	return 0;
+}
+
+static const struct hwmon_ops power_hwmon_ops = {
+	.is_visible = power_hwmon_attrs_visible,
+	.read = power_hwmon_read,
+	.write = power_hwmon_write,
+};
+
+static const struct hwmon_channel_info *power_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT |
+				  HWMON_P_MAX   | HWMON_P_MAX_ALARM |
+				  HWMON_P_CRIT  | HWMON_P_CRIT_ALARM),
+	NULL
+};
+
+static const struct hwmon_chip_info power_hwmon_chip_info = {
+	.ops = &power_hwmon_ops,
+	.info = power_hwmon_info,
+};
+
+static ssize_t power1_xeon_limit_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	u16 xeon_limit = 0;
+	u64 v;
+
+	v = readq(feature->ioaddr + FME_PWR_XEON_LIMIT);
+
+	if (FIELD_GET(XEON_PWR_EN, v))
+		xeon_limit = FIELD_GET(XEON_PWR_LIMIT, v);
+
+	return sprintf(buf, "%u\n", xeon_limit * 100000);
+}
+
+static ssize_t power1_fpga_limit_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	u16 fpga_limit = 0;
+	u64 v;
+
+	v = readq(feature->ioaddr + FME_PWR_FPGA_LIMIT);
+
+	if (FIELD_GET(FPGA_PWR_EN, v))
+		fpga_limit = FIELD_GET(FPGA_PWR_LIMIT, v);
+
+	return sprintf(buf, "%u\n", fpga_limit * 100000);
+}
+
+static ssize_t power1_ltr_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct dfl_feature *feature = dev_get_drvdata(dev);
+	u64 v;
+
+	v = readq(feature->ioaddr + FME_PWR_STATUS);
+
+	return sprintf(buf, "%u\n",
+		       (unsigned int)FIELD_GET(FME_LATENCY_TOLERANCE, v));
+}
+
+static DEVICE_ATTR_RO(power1_xeon_limit);
+static DEVICE_ATTR_RO(power1_fpga_limit);
+static DEVICE_ATTR_RO(power1_ltr);
+
+static struct attribute *power_extra_attrs[] = {
+	&dev_attr_power1_xeon_limit.attr,
+	&dev_attr_power1_fpga_limit.attr,
+	&dev_attr_power1_ltr.attr,
+	NULL
+};
+
+ATTRIBUTE_GROUPS(power_extra);
+
+static int fme_power_mgmt_init(struct platform_device *pdev,
+			       struct dfl_feature *feature)
+{
+	struct device *hwmon;
+
+	dev_dbg(&pdev->dev, "FME Power Management Init.\n");
+
+	hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
+						     "dfl_fme_power", feature,
+						     &power_hwmon_chip_info,
+						     power_extra_groups);
+	if (IS_ERR(hwmon)) {
+		dev_err(&pdev->dev, "Fail to register power hwmon\n");
+		return PTR_ERR(hwmon);
+	}
+
+	return 0;
+}
+
+static void fme_power_mgmt_uinit(struct platform_device *pdev,
+				 struct dfl_feature *feature)
+{
+	dev_dbg(&pdev->dev, "FME Power Management UInit.\n");
+}
+
+static const struct dfl_feature_id fme_power_mgmt_id_table[] = {
+	{.id = FME_FEATURE_ID_POWER_MGMT,},
+	{0,}
+};
+
+static const struct dfl_feature_ops fme_power_mgmt_ops = {
+	.init = fme_power_mgmt_init,
+	.uinit = fme_power_mgmt_uinit,
+};
+
 static struct dfl_feature_driver fme_feature_drvs[] = {
 	{
 		.id_table = fme_hdr_id_table,
@@ -418,6 +635,10 @@ static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
 		.ops = &fme_thermal_mgmt_ops,
 	},
 	{
+		.id_table = fme_power_mgmt_id_table,
+		.ops = &fme_power_mgmt_ops,
+	},
+	{
 		.ops = NULL,
 	},
 };
-- 
1.8.3.1

