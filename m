Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A573336668
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jun 2019 23:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfFEVKf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jun 2019 17:10:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39276 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726528AbfFEVKe (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Wed, 5 Jun 2019 17:10:34 -0400
Received: by mail-pg1-f196.google.com with SMTP id 196so24299pgc.6;
        Wed, 05 Jun 2019 14:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1bk3W8GvKiYa7pHQC6ltba8tgV2pMIu46n4SyBv5eF4=;
        b=Sr3s8PLBq+PtDjo+Zulwjm9GtPUc5YcRt28WlpECr6zeV/RhihKuXFllb0LPK/zxdy
         BgR9jDi+Nxf4ivDawQKKhmQKjDAYF1Y679z542/FLhuft4OVjn5BWGJuQNWco8VF5VO0
         nfEoiFMmZoVykd0HoBHkgpOlDu+KhWuEUxqiLnoEeKzYRmuAWMBWBh7fkAWdxexlPlVy
         8qp42mhk7unvfFRDZ+JuCSxxZk0jzAaZhRcCxTvFFU8SnkhT3oHK/1N/v2eIAGlEVMZ1
         4Bb15CJMWPiy5vay6FGGlUx6psyeMam/DZ4mFHx0nmhzD26hN2vtO5kEcVH/PbZPsH3Z
         2iug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=1bk3W8GvKiYa7pHQC6ltba8tgV2pMIu46n4SyBv5eF4=;
        b=Ud30HCP/PyvyYlgEwtNaT0XQHBfgUWg2BRwZWB9aD0ppktHyNs3FamYB6hpPweZGOs
         0eKTgbA8i5ev53NyOP0av7Y3eleHTof5MjxuK7SJztVZkA5Kin11klQAQ912QUABRbbj
         5Z9qXYKfoW4W+EcEBhrOJvNR1/sM7ISXu79tIyEEPBotGdfdz40OfVBBnezP6erVwnRc
         L6QfUfo6pAsGIGOlLrRnL4so5LaXaZ6nUnVb72DtKXnkdiAOnfhMnarPXZq4SPENk09M
         4YMJI+4tI79EqWjV4arbcQlVCXHasld3T0TwJ1hPH2BVGuBcjN5PH/8cVsq85csrM8/E
         BcgQ==
X-Gm-Message-State: APjAAAXZKAs1W8MU2mHthqbofUiZjxl4afYMvr8Z6+eKxgx9/e8oGuAp
        wRnJir+VtiMuT8ssBV1ndp3fCSko
X-Google-Smtp-Source: APXvYqy7YnGQ1uawxuTEf4y+VpAFVa6nvD2JHiPPmFH2DSByqantn/AAesIOCFfij+nIU+3pzi76dw==
X-Received: by 2002:a63:4419:: with SMTP id r25mr1030228pga.247.1559769033362;
        Wed, 05 Jun 2019 14:10:33 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 26sm5063196pfi.147.2019.06.05.14.10.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 14:10:32 -0700 (PDT)
Date:   Wed, 5 Jun 2019 14:10:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wu Hao <hao.wu@intel.com>
Cc:     atull@kernel.org, mdf@kernel.org, jdelvare@suse.com,
        linux-fpga@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Luwei Kang <luwei.kang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v3 2/3] fpga: dfl: fme: add thermal management support
Message-ID: <20190605211031.GA2730@roeck-us.net>
References: <1558937216-12742-1-git-send-email-hao.wu@intel.com>
 <1558937216-12742-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558937216-12742-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Mon, May 27, 2019 at 02:06:55PM +0800, Wu Hao wrote:
> This patch adds support to thermal management private feature for DFL
> FPGA Management Engine (FME). This private feature driver registers
> a hwmon for thermal/temperature monitoring (hwmon temp1_input).
> If hardware automatic throttling is supported by this hardware, then
> driver also exposes sysfs interfaces under hwmon for thresholds
> (temp1_max/ crit/ emergency), threshold alarms (temp1_max_alarm/
> temp1_crit_alarm) and throttling policy (temp1_max_policy).
> 
> Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> ----
> v2: create a dfl_fme_thermal hwmon to expose thermal information.
>     move all sysfs interfaces under hwmon
> 	tempareture       --> hwmon temp1_input
> 	threshold1        --> hwmon temp1_alarm
> 	threshold2        --> hwmon temp1_crit
> 	trip_threshold    --> hwmon temp1_emergency
> 	threshold1_status --> hwmon temp1_alarm_status
> 	threshold2_status --> hwmon temp1_crit_status
> 	threshold1_policy --> hwmon temp1_alarm_policy
> v3: rename some hwmon sysfs interfaces to follow hwmon ABI.
> 	temp1_alarm        --> temp1_max
> 	temp1_alarm_status --> temp1_max_alarm
> 	temp1_crit_status  --> temp1_crit_alarm
> 	temp1_alarm_policy --> temp1_max_policy
>     update sysfs doc for above sysfs interface changes.
>     replace scnprintf with sprintf in sysfs interface.
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-fme |  64 ++++++++
>  drivers/fpga/Kconfig                             |   2 +-
>  drivers/fpga/dfl-fme-main.c                      | 196 +++++++++++++++++++++++
>  3 files changed, 261 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index 63a02cb..0a0b7b9 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -212,3 +212,67 @@ Description:	Read-Write. Read this file for current status of port level
>  		fabric counters. Write "1" to enable port level fabric counters.
>  		Once port level fabric counters are enabled, device level fabric
>  		counters will be disabled automatically.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/name
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. Read this file to get the name of hwmon device, it
> +		supports values:
> +		    'dfl_fme_thermal' - thermal hwmon device name
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns FPGA device temperature in millidegrees
> +		Celsius.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns hardware threshold1 temperature in
> +		millidegrees Celsius. If temperature rises at or above this
> +		threshold, hardware starts 50% or 90% throttling (see
> +		'temp1_max_policy').
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns hardware threshold2 temperature in
> +		millidegrees Celsius. If temperature rises at or above this
> +		threshold, hardware starts 100% throttling.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_emergency
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns hardware trip threshold temperature in
> +		millidegrees Celsius. If temperature rises at or above this
> +		threshold, a fatal event will be triggered to board management
> +		controller (BMC) to shutdown FPGA.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max_alarm
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if temperature is currently at or above
> +		hardware threshold1 (see 'temp1_max'), otherwise 0.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit_alarm
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if temperature is currently at or above
> +		hardware threshold2 (see 'temp1_crit'), otherwise 0.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max_policy
> +Date:		May 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. Read this file to get the policy of hardware threshold1
> +		(see 'temp1_max'). It only supports two values (policies):
> +		    0 - AP2 state (90% throttling)
> +		    1 - AP1 state (50% throttling)
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index d892f3e..36551d6 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -154,7 +154,7 @@ config FPGA_DFL
>  
>  config FPGA_DFL_FME
>  	tristate "FPGA DFL FME Driver"
> -	depends on FPGA_DFL
> +	depends on FPGA_DFL && HWMON
>  	help
>  	  The FPGA Management Engine (FME) is a feature device implemented
>  	  under Device Feature List (DFL) framework. Select this option to
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 4a5b25d..91152d5 100644
> --- a/drivers/fpga/dfl-fme-main.c
> +++ b/drivers/fpga/dfl-fme-main.c
> @@ -14,6 +14,8 @@
>   *   Henry Mitchel <henry.mitchel@intel.com>
>   */
>  
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/uaccess.h>
> @@ -217,6 +219,196 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  	.ioctl = fme_hdr_ioctl,
>  };
>  
> +#define FME_THERM_THRESHOLD	0x8
> +#define TEMP_THRESHOLD1		GENMASK_ULL(6, 0)
> +#define TEMP_THRESHOLD1_EN	BIT_ULL(7)
> +#define TEMP_THRESHOLD2		GENMASK_ULL(14, 8)
> +#define TEMP_THRESHOLD2_EN	BIT_ULL(15)
> +#define TRIP_THRESHOLD		GENMASK_ULL(30, 24)
> +#define TEMP_THRESHOLD1_STATUS	BIT_ULL(32)		/* threshold1 reached */
> +#define TEMP_THRESHOLD2_STATUS	BIT_ULL(33)		/* threshold2 reached */
> +/* threshold1 policy: 0 - AP2 (90% throttle) / 1 - AP1 (50% throttle) */
> +#define TEMP_THRESHOLD1_POLICY	BIT_ULL(44)
> +
> +#define FME_THERM_RDSENSOR_FMT1	0x10
> +#define FPGA_TEMPERATURE	GENMASK_ULL(6, 0)
> +
> +#define FME_THERM_CAP		0x20
> +#define THERM_NO_THROTTLE	BIT_ULL(0)
> +
> +#define MD_PRE_DEG
> +
> +static bool fme_thermal_throttle_support(void __iomem *base)
> +{
> +	u64 v = readq(base + FME_THERM_CAP);
> +
> +	return FIELD_GET(THERM_NO_THROTTLE, v) ? false : true;
> +}
> +
> +static umode_t thermal_hwmon_attrs_visible(const void *drvdata,
> +					   enum hwmon_sensor_types type,
> +					   u32 attr, int channel)
> +{
> +	const struct dfl_feature *feature = drvdata;
> +
> +	/* temperature is always supported, and check hardware cap for others */
> +	if (attr == hwmon_temp_input)
> +		return 0444;
> +
> +	return fme_thermal_throttle_support(feature->ioaddr) ? 0444 : 0;
> +}
> +
> +static int thermal_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> +			      u32 attr, int channel, long *val)
> +{
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	u64 v;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		v = readq(feature->ioaddr + FME_THERM_RDSENSOR_FMT1);
> +		*val = (long)(FIELD_GET(FPGA_TEMPERATURE, v) * 1000);
> +		break;
> +	case hwmon_temp_max:
> +		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +		*val = (long)(FIELD_GET(TEMP_THRESHOLD1, v) * 1000);
> +		break;
> +	case hwmon_temp_crit:
> +		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +		*val = (long)(FIELD_GET(TEMP_THRESHOLD2, v) * 1000);
> +		break;
> +	case hwmon_temp_emergency:
> +		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +		*val = (long)(FIELD_GET(TRIP_THRESHOLD, v) * 1000);
> +		break;
> +	case hwmon_temp_max_alarm:
> +		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +		*val = (long)FIELD_GET(TEMP_THRESHOLD1_STATUS, v);
> +		break;
> +	case hwmon_temp_crit_alarm:
> +		v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +		*val = (long)FIELD_GET(TEMP_THRESHOLD2_STATUS, v);
> +		break;
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct hwmon_ops thermal_hwmon_ops = {
> +	.is_visible = thermal_hwmon_attrs_visible,
> +	.read = thermal_hwmon_read,
> +};
> +
> +static const u32 thermal_hwmon_temp_config[] = {
> +	HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT | HWMON_T_EMERGENCY |
> +	HWMON_T_MAX_ALARM | HWMON_T_CRIT_ALARM,
> +	0
> +};
> +
> +static const struct hwmon_channel_info hwmon_temp_info = {
> +	.type = hwmon_temp,
> +	.config = thermal_hwmon_temp_config,
> +};
> +
> +static const struct hwmon_channel_info *thermal_hwmon_info[] = {
> +	&hwmon_temp_info,
> +	NULL
> +};

Please use the HWMON_CHANNEL_INFO() macro to reduce boilerplate code.

Thanks,
Guenter

> +
> +static const struct hwmon_chip_info thermal_hwmon_chip_info = {
> +	.ops = &thermal_hwmon_ops,
> +	.info = thermal_hwmon_info,
> +};
> +
> +static ssize_t temp1_max_policy_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +	u64 v;
> +
> +	v = readq(feature->ioaddr + FME_THERM_THRESHOLD);
> +
> +	return sprintf(buf, "%u\n",
> +		       (unsigned int)FIELD_GET(TEMP_THRESHOLD1_POLICY, v));
> +}
> +
> +static DEVICE_ATTR_RO(temp1_max_policy);
> +
> +static struct attribute *thermal_extra_attrs[] = {
> +	&dev_attr_temp1_max_policy.attr,
> +	NULL,
> +};
> +
> +static umode_t thermal_extra_attrs_visible(struct kobject *kobj,
> +					   struct attribute *attr, int index)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct dfl_feature *feature = dev_get_drvdata(dev);
> +
> +	return fme_thermal_throttle_support(feature->ioaddr) ? attr->mode : 0;
> +}
> +
> +static const struct attribute_group thermal_extra_group = {
> +	.attrs		= thermal_extra_attrs,
> +	.is_visible	= thermal_extra_attrs_visible,
> +};
> +__ATTRIBUTE_GROUPS(thermal_extra);
> +
> +static int fme_thermal_mgmt_init(struct platform_device *pdev,
> +				 struct dfl_feature *feature)
> +{
> +	struct device *hwmon;
> +
> +	dev_dbg(&pdev->dev, "FME Thermal Management Init.\n");
> +
> +	/*
> +	 * create hwmon to allow userspace monitoring temperature and other
> +	 * threshold information.
> +	 *
> +	 * temp1_input      -> FPGA device temperature
> +	 * temp1_max        -> hardware threshold 1 -> 50% or 90% throttling
> +	 * temp1_crit       -> hardware threshold 2 -> 100% throttling
> +	 * temp1_emergency  -> hardware trip_threshold to shutdown FPGA
> +	 * temp1_max_alarm  -> hardware threshold 1 alarm
> +	 * temp1_crit_alarm -> hardware threshold 2 alarm
> +	 *
> +	 * create device specific sysfs interfaces, e.g. read temp1_max_policy
> +	 * to understand the actual hardware throttling action (50% vs 90%).
> +	 *
> +	 * If hardware doesn't support automatic throttling per thresholds,
> +	 * then all above sysfs interfaces are not visible except temp1_input
> +	 * for temperature.
> +	 */
> +	hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
> +						     "dfl_fme_thermal", feature,
> +						     &thermal_hwmon_chip_info,
> +						     thermal_extra_groups);
> +	if (IS_ERR(hwmon)) {
> +		dev_err(&pdev->dev, "Fail to register thermal hwmon\n");
> +		return PTR_ERR(hwmon);
> +	}
> +
> +	return 0;
> +}
> +
> +static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
> +				   struct dfl_feature *feature)
> +{
> +	dev_dbg(&pdev->dev, "FME Thermal Management UInit.\n");
> +}
> +
> +static const struct dfl_feature_id fme_thermal_mgmt_id_table[] = {
> +	{.id = FME_FEATURE_ID_THERMAL_MGMT,},
> +	{0,}
> +};
> +
> +static const struct dfl_feature_ops fme_thermal_mgmt_ops = {
> +	.init = fme_thermal_mgmt_init,
> +	.uinit = fme_thermal_mgmt_uinit,
> +};
> +
>  static struct dfl_feature_driver fme_feature_drvs[] = {
>  	{
>  		.id_table = fme_hdr_id_table,
> @@ -235,6 +427,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  		.ops = &fme_perf_ops,
>  	},
>  	{
> +		.id_table = fme_thermal_mgmt_id_table,
> +		.ops = &fme_thermal_mgmt_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	},
>  };
