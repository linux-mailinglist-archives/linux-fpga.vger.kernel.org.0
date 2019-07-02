Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77CBD5C855
	for <lists+linux-fpga@lfdr.de>; Tue,  2 Jul 2019 06:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGBE0j (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 2 Jul 2019 00:26:39 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:34063 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbfGBE0j (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 2 Jul 2019 00:26:39 -0400
Received: by mail-pg1-f195.google.com with SMTP id p10so7042599pgn.1;
        Mon, 01 Jul 2019 21:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jP3zrleZutpLX8FmyTIPTOEboocXfvM0sydGHV1Coq0=;
        b=L/KCM8GLwn8PppPQFBCOOtv7QrgHZHJKP95caV5URVr971BV7feLCweJ+nAw38vbXo
         Mk2ZGxy0RVOw9K/Pg6KePykz1SbRHQdZV0/mSJOT2/cjz3lkSifuLhdbFrw2LREi4nNZ
         z68t62KWncadbjm95ZTDx0RXWweyDKA0feEEbHrGfQcKZiLUEOWWsAtK5QbaCTFhvNWs
         qg+UfJxT9awEQ8HepfqHI3yDx1oD7lB9h9H7LbXz9CIEc2BVTiPdi7Za7oWL/K4hW9S7
         WZ2SSGnQ4cKUaYUaMkBerDS8XlVaP6OCz5L6GTWJgHH8rSiG6vJpA70sZ5IeL6NdEiRD
         aXWw==
X-Gm-Message-State: APjAAAXjMQOMqxaMRf6Dp/V6imc6pmg1rPp0zri6vRTzmAhEaH/eSX6y
        /ku4f6eXPAI9kUp7Y6XXRq9wJGHgAko=
X-Google-Smtp-Source: APXvYqyWEZQg1zd5yIG7pyhphwdi/OZQVHOV4J0iU3Jm58CU7XBGAj6a3cHA25fXfi0WGxeSIzfb7Q==
X-Received: by 2002:a65:538d:: with SMTP id x13mr28641509pgq.190.1562041598381;
        Mon, 01 Jul 2019 21:26:38 -0700 (PDT)
Received: from localhost ([2601:647:5b80:29f7:aba9:7dd5:dfa6:e012])
        by smtp.gmail.com with ESMTPSA id q5sm11951299pgj.49.2019.07.01.21.26.37
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 21:26:37 -0700 (PDT)
Date:   Mon, 1 Jul 2019 21:26:37 -0700
From:   Moritz Fischer <mdf@kernel.org>
To:     Wu Hao <hao.wu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com, linux@roeck-us.net,
        atull@kernel.org, gregkh@linuxfoundation.org,
        Luwei Kang <luwei.kang@intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH v5 2/3] fpga: dfl: fme: add thermal management support
Message-ID: <20190702042637.GB21853@archbook>
References: <1561963027-4213-1-git-send-email-hao.wu@intel.com>
 <1561963027-4213-3-git-send-email-hao.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1561963027-4213-3-git-send-email-hao.wu@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Hi Hao,

On Mon, Jul 01, 2019 at 02:37:06PM +0800, Wu Hao wrote:
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
> Acked-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
> ---
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
> v4: use HWMON_CHANNEL_INFO.
>     rebase, and update date in sysfs doc.
> v5: no change.
> ---
>  Documentation/ABI/testing/sysfs-platform-dfl-fme |  64 ++++++++
>  drivers/fpga/Kconfig                             |   2 +-
>  drivers/fpga/dfl-fme-main.c                      | 187 +++++++++++++++++++++++
>  3 files changed, 252 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> index 86eef83..2cd17dc 100644
> --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> @@ -119,3 +119,67 @@ Description:	Write-only. Write error code to this file to clear all errors
>  		logged in errors, first_error and next_error. Write fails with
>  		-EINVAL if input parsing fails or input error code doesn't
>  		match.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/name
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. Read this file to get the name of hwmon device, it
> +		supports values:
> +		    'dfl_fme_thermal' - thermal hwmon device name
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns FPGA device temperature in millidegrees
> +		Celsius.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns hardware threshold1 temperature in
> +		millidegrees Celsius. If temperature rises at or above this
> +		threshold, hardware starts 50% or 90% throttling (see
> +		'temp1_max_policy').
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns hardware threshold2 temperature in
> +		millidegrees Celsius. If temperature rises at or above this
> +		threshold, hardware starts 100% throttling.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_emergency
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. It returns hardware trip threshold temperature in
> +		millidegrees Celsius. If temperature rises at or above this
> +		threshold, a fatal event will be triggered to board management
> +		controller (BMC) to shutdown FPGA.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max_alarm
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if temperature is currently at or above
> +		hardware threshold1 (see 'temp1_max'), otherwise 0.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_crit_alarm
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-only. It returns 1 if temperature is currently at or above
> +		hardware threshold2 (see 'temp1_crit'), otherwise 0.
> +
> +What:		/sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_max_policy
> +Date:		June 2019
> +KernelVersion:	5.3
> +Contact:	Wu Hao <hao.wu@intel.com>
> +Description:	Read-Only. Read this file to get the policy of hardware threshold1
> +		(see 'temp1_max'). It only supports two values (policies):
> +		    0 - AP2 state (90% throttling)
> +		    1 - AP1 state (50% throttling)
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 8072c19..48f6224 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -155,7 +155,7 @@ config FPGA_DFL
>  
>  config FPGA_DFL_FME
>  	tristate "FPGA DFL FME Driver"
> -	depends on FPGA_DFL
> +	depends on FPGA_DFL && HWMON
>  	help
>  	  The FPGA Management Engine (FME) is a feature device implemented
>  	  under Device Feature List (DFL) framework. Select this option to
> diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> index 4490cf4..59ff9f1 100644
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
> @@ -217,6 +219,187 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
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
> +static const struct hwmon_channel_info *thermal_hwmon_info[] = {
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_EMERGENCY |
> +				 HWMON_T_MAX   | HWMON_T_MAX_ALARM |
> +				 HWMON_T_CRIT  | HWMON_T_CRIT_ALARM),
> +	NULL
> +};
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
> @@ -231,6 +414,10 @@ static long fme_hdr_ioctl(struct platform_device *pdev,
>  		.ops = &fme_global_err_ops,
>  	},
>  	{
> +		.id_table = fme_thermal_mgmt_id_table,
> +		.ops = &fme_thermal_mgmt_ops,
> +	},
> +	{
>  		.ops = NULL,
>  	},
>  };
> -- 
> 1.8.3.1
> 
