Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2F55BCD6
	for <lists+linux-fpga@lfdr.de>; Mon,  1 Jul 2019 15:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbfGANZM (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 1 Jul 2019 09:25:12 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35867 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727009AbfGANZM (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Mon, 1 Jul 2019 09:25:12 -0400
Received: by mail-pg1-f193.google.com with SMTP id c13so6061404pgg.3;
        Mon, 01 Jul 2019 06:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BolpC+dvtytKXBbmWUIWGyQQJiFM1T9QVGgjh2h+lAo=;
        b=TxlqhtvXlBkFShE/qZ8R9tm4M3nUuRiTjrYLm75CyhKIhhjXqb+XF5m/QlU6L+14vj
         sYfiDhy+wjHZ9xgpWYmjlxscArq7ukM0x17EGGMfhYP2SGCNmKs3cIjdf4DO9hYoIfgi
         LK6fD0GL+Idt5W7wmHXdED0HS4Zzi3nY8v1RY2zBGSYxdKgLGyuQWEc89wt72oClaptC
         IarTvPRPvyKLqWgCYSjWtpaotDyZL8qGPveBKBUhLUHax2Nn43hltTURPuX2Zlax44X1
         x4vmmY8BR6lAW99uRfWkqIuhlXR+lOHVsKU+D+KWL6qMTIdC12oO4IXCkvmbGay3BPdX
         Vo1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BolpC+dvtytKXBbmWUIWGyQQJiFM1T9QVGgjh2h+lAo=;
        b=E8d7jxpi6FelVhZVzGWHRdwON7vg4H8IRWsVVGfAKDPnS1QtSmoVbfJSLhRHutMZcD
         ecwMuH8gtFR+N41YrpnDtxn/vq8hxfuv9E1XKZUtKG/SWD1smKJnwnfwCiKyxhGeIu/d
         wXoqG2QUR01iOWWcADn49QipIeKO+cmBM+6N1uwo2kladdYh10kohCCqchaTquO4u9dS
         9AC8mFetQvBb4Vy1OPNXfuZEJlIHKaidEpSY903DzJ+EKEtL8OJ1LMLEAtufY7tI3e+a
         iZL2gFYcCXRjAmpg6esTAZoC7CPQjr40dZx9KIfEapffZedKnhBqebfR12+bh9Mkg5g/
         e+uA==
X-Gm-Message-State: APjAAAXq6e0VKf4NRAICKDlYVfaRNFvCsXguZ84wvRW92m0/hc/zby1C
        oXa0vIbgjB0TjZBwaRmQpOs=
X-Google-Smtp-Source: APXvYqwIzQ+pX6RKn7hsE9FVpbH8GC+fPYeUoyuhg5wMqA0a5MF9CJbPvm2ZsnOp/shT/hBLjN00KA==
X-Received: by 2002:a17:90a:ba94:: with SMTP id t20mr32463290pjr.116.1561987511013;
        Mon, 01 Jul 2019 06:25:11 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s20sm10260979pfe.169.2019.07.01.06.25.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:25:10 -0700 (PDT)
Subject: Re: [PATCH v5 3/3] fpga: dfl: fme: add power management support
To:     Wu Hao <hao.wu@intel.com>, mdf@kernel.org,
        linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, atull@kernel.org, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
References: <1561963027-4213-1-git-send-email-hao.wu@intel.com>
 <1561963027-4213-4-git-send-email-hao.wu@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <af2d0724-ac7d-c35a-b640-3f8c3fb35ad4@roeck-us.net>
Date:   Mon, 1 Jul 2019 06:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <1561963027-4213-4-git-send-email-hao.wu@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On 6/30/19 11:37 PM, Wu Hao wrote:
> This patch adds support for power management private feature under
> FPGA Management Engine (FME). This private feature driver registers
> a hwmon for power (power1_input), thresholds information, e.g.
> (power1_max / crit / max_alarm / crit_alarm) and also read-only sysfs
> interfaces for other power management information. For configuration,
> user could write threshold values via above power1_max / crit sysfs
> interface under hwmon too.
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
> v2: create a dfl_fme_power hwmon to expose power sysfs interfaces.
>      move all sysfs interfaces under hwmon
>          consumed          --> hwmon power1_input
>          threshold1        --> hwmon power1_cap
>          threshold2        --> hwmon power1_crit
>          threshold1_status --> hwmon power1_cap_status
>          threshold2_status --> hwmon power1_crit_status
>          xeon_limit        --> hwmon power1_xeon_limit
>          fpga_limit        --> hwmon power1_fpga_limit
>          ltr               --> hwmon power1_ltr
> v3: rename some hwmon sysfs interfaces to follow hwmon ABI.
> 	power1_cap         --> power1_max
> 	power1_cap_status  --> power1_max_alarm
> 	power1_crit_status --> power1_crit_alarm
>      update sysfs doc for above sysfs interface changes.
>      replace scnprintf with sprintf in sysfs interface.
> v4: use HWMON_CHANNEL_INFO.
>      update date in sysfs doc.
> v5: clamp threshold inputs in power_hwmon_write function.
>      update sysfs doc as threshold inputs are clamped now.
>      add more descriptions to ltr sysfs interface.
> ---
>   Documentation/ABI/testing/sysfs-platform-dfl-fme |  68 +++++++
>   drivers/fpga/dfl-fme-main.c                      | 216 +++++++++++++++++++++++
>   2 files changed, 284 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index 2cd17dc..5c2e49d 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -127,6 +127,7 @@ Contact:	Wu Hao <hao.wu@intel.com>
>   Description:	Read-Only. Read this file to get the name of hwmon device, it
>   		supports values:
>   		    'dfl_fme_thermal' - thermal hwmon device name
> +		    'dfl_fme_power'   - power hwmon device name
>   
>   What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
>   Date:		June 2019
> @@ -183,3 +184,70 @@ Description:	Read-Only. Read this file to get the policy of hardware threshold1
>   		(see 'temp1_max'). It only supports two values (policies):
>   		    0 - AP2 state (90% throttling)
>   		    1 - AP1 state (50% throttling)
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_input
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns current FPGA power consumption in uW.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_max
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Write. Read this file to get current hardware power
> +		threshold1 in uW. If power consumption rises at or above
> +		this threshold, hardware starts 50% throttling.
> +		Write this file to set current hardware power threshold1 in uW.
> +		As hardware only accepts values in Watts, so input value will
> +		be round down per Watts (< 1 watts part will be discarded) and
> +		clamped within the range from 0 to 127 Watts. Write fails with
> +		-EINVAL if input parsing fails.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_crit
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Write. Read this file to get current hardware power
> +		threshold2 in uW. If power consumption rises at or above
> +		this threshold, hardware starts 90% throttling.
> +		Write this file to set current hardware power threshold2 in uW.
> +		As hardware only accepts values in Watts, so input value will
> +		be round down per Watts (< 1 watts part will be discarded) and
> +		clamped within the range from 0 to 127 Watts. Write fails with
> +		-EINVAL if input parsing fails.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_max_alarm
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if power consumption is currently at or
> +		above hardware threshold1 (see 'power1_max'), otherwise 0.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_crit_alarm
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if power consumption is currently at or
> +		above hardware threshold2 (see 'power1_crit'), otherwise 0.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_xeon_limit
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns power limit for XEON in uW.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_fpga_limit
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns power limit for FPGA in uW.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_ltr
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. Read this file to get current Latency Tolerance
> +		Reporting (ltr) value. It returns 1 if all Accelerated
> +		Function Units (AFUs) can tolerate latency >= 40us for memory
> +		access or 0 if any AFU is latency sensitive (< 40us).
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 59ff9f1..1ff386d 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -400,6 +400,218 @@ static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
>   	.uinit = fme_thermal_mgmt_uinit,
>   };
>   
> +#define FME_PWR_STATUS		0x8
> +#define FME_LATENCY_TOLERANCE	BIT_ULL(18)
> +#define PWR_CONSUMED		GENMASK_ULL(17, 0)
> +
> +#define FME_PWR_THRESHOLD	0x10
> +#define PWR_THRESHOLD1		GENMASK_ULL(6, 0)	/* in Watts */
> +#define PWR_THRESHOLD2		GENMASK_ULL(14, 8)	/* in Watts */
> +#define PWR_THRESHOLD_MAX	0x7f			/* in Watts */
> +#define PWR_THRESHOLD1_STATUS	BIT_ULL(16)
> +#define PWR_THRESHOLD2_STATUS	BIT_ULL(17)
> +
> +#define FME_PWR_XEON_LIMIT	0x18
> +#define XEON_PWR_LIMIT		GENMASK_ULL(14, 0)	/* in 0.1 Watts */
> +#define XEON_PWR_EN		BIT_ULL(15)
> +#define FME_PWR_FPGA_LIMIT	0x20
> +#define FPGA_PWR_LIMIT		GENMASK_ULL(14, 0)	/* in 0.1 Watts */
> +#define FPGA_PWR_EN		BIT_ULL(15)
> +
> +static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			    u32 attr, int channel, long *val)
> +{
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	u64 v;
> +
> +	switch (attr) {
> +	case hwmon_power_input:
> +		v = readq(feature->ioaddr + FME_PWR_STATUS);
> +		*val = (long)(FIELD_GET(PWR_CONSUMED, v) * 1000000);
> +		break;
> +	case hwmon_power_max:
> +		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> +		*val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * 1000000);
> +		break;
> +	case hwmon_power_crit:
> +		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> +		*val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * 1000000);
> +		break;
> +	case hwmon_power_max_alarm:
> +		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> +		*val = (long)FIELD_GET(PWR_THRESHOLD1_STATUS, v);
> +		break;
> +	case hwmon_power_crit_alarm:
> +		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> +		*val = (long)FIELD_GET(PWR_THRESHOLD2_STATUS, v);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> +			     u32 attr, int channel, long val)
> +{
> +	struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	int ret = 0;
> +	u64 v;
> +
> +	val = clamp_val(val / 1000000, 0, PWR_THRESHOLD_MAX);
> +
> +	mutex_lock(&pdata->lock);
> +
> +	switch (attr) {
> +	case hwmon_power_max:
> +		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> +		v &= ~PWR_THRESHOLD1;
> +		v |= FIELD_PREP(PWR_THRESHOLD1, val);
> +		writeq(v, feature->ioaddr + FME_PWR_THRESHOLD);
> +		break;
> +	case hwmon_power_crit:
> +		v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> +		v &= ~PWR_THRESHOLD2;
> +		v |= FIELD_PREP(PWR_THRESHOLD2, val);
> +		writeq(v, feature->ioaddr + FME_PWR_THRESHOLD);
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	mutex_unlock(&pdata->lock);
> +
> +	return ret;
> +}
> +
> +static umode_t power_hwmon_attrs_visible(const void *drvdata,
> +					 enum hwmon_sensor_types type,
> +					 u32 attr, int channel)
> +{
> +	switch (attr) {
> +	case hwmon_power_input:
> +	case hwmon_power_max_alarm:
> +	case hwmon_power_crit_alarm:
> +		return 0444;
> +	case hwmon_power_max:
> +	case hwmon_power_crit:
> +		return 0644;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops power_hwmon_ops = {
> +	.is_visible = power_hwmon_attrs_visible,
> +	.read = power_hwmon_read,
> +	.write = power_hwmon_write,
> +};
> +
> +static const struct hwmon_channel_info *power_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(power, HWMON_P_INPUT |
> +				  HWMON_P_MAX   | HWMON_P_MAX_ALARM |
> +				  HWMON_P_CRIT  | HWMON_P_CRIT_ALARM),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info power_hwmon_chip_info = {
> +	.ops = &power_hwmon_ops,
> +	.info = power_hwmon_info,
> +};
> +
> +static ssize_t power1_xeon_limit_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	u16 xeon_limit = 0;
> +	u64 v;
> +
> +	v = readq(feature->ioaddr + FME_PWR_XEON_LIMIT);
> +
> +	if (FIELD_GET(XEON_PWR_EN, v))
> +		xeon_limit = FIELD_GET(XEON_PWR_LIMIT, v);
> +
> +	return sprintf(buf, "%u\n", xeon_limit * 100000);
> +}
> +
> +static ssize_t power1_fpga_limit_show(struct device *dev,
> +				      struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	u16 fpga_limit = 0;
> +	u64 v;
> +
> +	v = readq(feature->ioaddr + FME_PWR_FPGA_LIMIT);
> +
> +	if (FIELD_GET(FPGA_PWR_EN, v))
> +		fpga_limit = FIELD_GET(FPGA_PWR_LIMIT, v);
> +
> +	return sprintf(buf, "%u\n", fpga_limit * 100000);
> +}
> +
> +static ssize_t power1_ltr_show(struct device *dev,
> +			       struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	u64 v;
> +
> +	v = readq(feature->ioaddr + FME_PWR_STATUS);
> +
> +	return sprintf(buf, "%u\n",
> +		       (unsigned int)FIELD_GET(FME_LATENCY_TOLERANCE, v));
> +}
> +
> +static DEVICE_ATTR_RO(power1_xeon_limit);
> +static DEVICE_ATTR_RO(power1_fpga_limit);
> +static DEVICE_ATTR_RO(power1_ltr);
> +
> +static struct attribute *power_extra_attrs[] = {
> +	&dev_attr_power1_xeon_limit.attr,
> +	&dev_attr_power1_fpga_limit.attr,
> +	&dev_attr_power1_ltr.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(power_extra);
> +
> +static int fme_power_mgmt_init(struct platform_device *pdev,
> +			       struct dfl_feature *feature)
> +{
> +	struct device *hwmon;
> +
> +	dev_dbg(&pdev->dev, "FME Power Management Init.\n");
> +
> +	hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
> +						     "dfl_fme_power", feature,
> +						     &power_hwmon_chip_info,
> +						     power_extra_groups);
> +	if (IS_ERR(hwmon)) {
> +		dev_err(&pdev->dev, "Fail to register power hwmon\n");
> +		return PTR_ERR(hwmon);
> +	}
> +
> +	return 0;
> +}
> +
> +static void fme_power_mgmt_uinit(struct platform_device *pdev,
> +				 struct dfl_feature *feature)
> +{
> +	dev_dbg(&pdev->dev, "FME Power Management UInit.\n");
> +}
> +
> +static const struct dfl_feature_id fme_power_mgmt_id_table[] = {
> +	{.id = FME_FEATURE_ID_POWER_MGMT,},
> +	{0,}
> +};
> +
> +static const struct dfl_feature_ops fme_power_mgmt_ops = {
> +	.init = fme_power_mgmt_init,
> +	.uinit = fme_power_mgmt_uinit,
> +};
> +
>   static struct dfl_feature_driver fme_feature_drvs[] = {
>   	{
>   		.id_table = fme_hdr_id_table,
> @@ -418,6 +630,10 @@ static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
>   		.ops = &fme_thermal_mgmt_ops,
>   	},
>   	{
> +		.id_table = fme_power_mgmt_id_table,
> +		.ops = &fme_power_mgmt_ops,
> +	},
> +	{
>   		.ops = NULL,
>   	},
>   };
> 

