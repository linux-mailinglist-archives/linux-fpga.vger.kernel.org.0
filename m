Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D116A47
	for <lists+linux-fpga@lfdr.de>; Tue,  7 May 2019 20:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbfEGSgZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 7 May 2019 14:36:25 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35624 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEGSgZ (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 7 May 2019 14:36:25 -0400
Received: by mail-pl1-f196.google.com with SMTP id w24so8612556plp.2;
        Tue, 07 May 2019 11:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X/8P0uSsoHB06zEoCFFSSAaStc5eSh8fKKDW+tM8xtQ=;
        b=dapCrmrOWbjifNTgoyGNk4EesTgzyf3eOZ+x0FSmKsmielVLB/iLkf48hLGJYsCQR/
         NLpYXy1Nteqz2iXArLs76BQhMQxmQI499boIIIj4FIrAx4wmLFR6sueYd57mGBHmyYd5
         Ej3jh3N2pkmJ3El0AWIuZ+UMAd4hOzzVxNepTg4c7N+EcjDuSxXgaG7vH+dFnbvdcTWB
         ljg/y1tlKMoGuQU5Php/uW8NLGdG0AGXfEPhbcXKZmJv5EptXRe3SeEMiwTf+kKS3i4p
         6Lb14iXoWqgQ9+QbfhN1vUSYY9y6iNlLs4vEst1mFnBRgDTf1jXJJpZZyK4IwhLMraFS
         7bcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=X/8P0uSsoHB06zEoCFFSSAaStc5eSh8fKKDW+tM8xtQ=;
        b=S/n10F1zIHTymitvK1LVDkG+IblX9p7XIFTfiPREoznNVz1bDNxxdzK6D6XC6oln0I
         GlHWk1tG90+plbKIAHnWx71XZ5Hm4w/9G3gYmPw9zjhfPD9Vmwcde406HBGqalXRwFAK
         wrpYEZG3QNnUKyqkXDibrIT1trJ+9XtJ/JXkt8oFBeUXP5PeQU1ojU+CEUQzJlanTPNs
         rHJ9gwZFqGiUXxpZQW0BOij84SX8rQKBQbGedZ+CRRx/PlLz7KaN2LalAu0sIHO4zmhi
         YGFP3GS4ShFqK8rVfOOlFNJvyZI+T7rkYWHokEojWlRmQjHyUdcOjjGO/rWUX5ZxL6aq
         zKAA==
X-Gm-Message-State: APjAAAUyLPGPVQkQvVD4VzFuB+LA3HMSz4cey1vmdWqnIB7jCxbHg8RB
        zImoTIOs0hSdg2aFYCpaxAE=
X-Google-Smtp-Source: APXvYqx0K3HvB0w0qhOwWinUp66H1gHGFX67aUgbgiQbKXtTJH4xUwVni65hEOEvDmUUTwhtXileeA==
X-Received: by 2002:a17:902:9042:: with SMTP id w2mr41515008plz.91.1557254184583;
        Tue, 07 May 2019 11:36:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y10sm20040468pfm.27.2019.05.07.11.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 11:36:23 -0700 (PDT)
Date:   Tue, 7 May 2019 11:36:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alan Tull <atull@kernel.org>
Cc:     Wu Hao <hao.wu@intel.com>, Moritz Fischer <mdf@kernel.org>,
        linux-fpga@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Luwei Kang <luwei.kang@intel.com>,
        Xu Yilun <yilun.xu@intel.com>,
        Jean Delvare <jdelvare@suse.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v2 16/18] fpga: dfl: fme: add power management support
Message-ID: <20190507183623.GC29510@roeck-us.net>
References: <1556528151-17221-1-git-send-email-hao.wu@intel.com>
 <1556528151-17221-17-git-send-email-hao.wu@intel.com>
 <CANk1AXQoYW_a_Jz_X_RCQtJpLn++dv8vAn4Yz+w+eRcZhrELGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANk1AXQoYW_a_Jz_X_RCQtJpLn++dv8vAn4Yz+w+eRcZhrELGQ@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, May 07, 2019 at 01:23:33PM -0500, Alan Tull wrote:
> On Mon, Apr 29, 2019 at 4:13 AM Wu Hao <hao.wu@intel.com> wrote:
> 
> + hwmon folks
> 
> >
> > This patch adds support for power management private feature under
> > FPGA Management Engine (FME). This private feature driver registers
> > a hwmon for power (power1_input), thresholds information, e.g.
> > (power1_cap / crit) and also read-only sysfs interfaces for other
> > power management information. For configuration, user could write
> > threshold values via above power1_cap / crit sysfs interface
> > under hwmon too.
> >
> > Signed-off-by: Luwei Kang <luwei.kang@intel.com>
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > ---
> > v2: create a dfl_fme_power hwmon to expose power sysfs interfaces.
> >     move all sysfs interfaces under hwmon
> >         consumed          --> hwmon power1_input
> >         threshold1        --> hwmon power1_cap
> >         threshold2        --> hwmon power1_crit
> >         threshold1_status --> hwmon power1_cap_status
> >         threshold2_status --> hwmon power1_crit_status
> >         xeon_limit        --> hwmon power1_xeon_limit
> >         fpga_limit        --> hwmon power1_fpga_limit
> >         ltr               --> hwmon power1_ltr

Same response as before.

Guenter

> > ---
> >  Documentation/ABI/testing/sysfs-platform-dfl-fme |  67 ++++++
> >  drivers/fpga/dfl-fme-main.c                      | 247 +++++++++++++++++++++++
> >  2 files changed, 314 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-platform-dfl-fme b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > index dfbd315..e2ba92d 100644
> > --- a/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > +++ b/Documentation/ABI/testing/sysfs-platform-dfl-fme
> > @@ -52,6 +52,7 @@ Contact:      Wu Hao <hao.wu@intel.com>
> >  Description:   Read-Only. Read this file to get the name of hwmon device, it
> >                 supports values:
> >                     'dfl_fme_thermal' - thermal hwmon device name
> > +                   'dfl_fme_power'   - power hwmon device name
> >
> >  What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/temp1_input
> >  Date:          April 2019
> > @@ -108,3 +109,69 @@ Description:       Read-Only. Read this file to get the policy of hardware threshold1
> >                 (see 'temp1_alarm'). It only supports two values (policies):
> >                     0 - AP2 state (90% throttling)
> >                     1 - AP1 state (50% throttling)
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_input
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. It returns current FPGA power consumption in uW.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_cap
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file to get current hardware power
> > +               threshold1 in uW. If power consumption rises at or above
> > +               this threshold, hardware starts 50% throttling.
> > +               Write this file to set current hardware power threshold1 in uW.
> > +               As hardware only accepts values in Watts, so input value will
> > +               be round down per Watts (< 1 watts part will be discarded).
> > +               Write fails with -EINVAL if input parsing fails or input isn't
> > +               in the valid range (0 - 127000000 uW).
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_crit
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Write. Read this file to get current hardware power
> > +               threshold2 in uW. If power consumption rises at or above
> > +               this threshold, hardware starts 90% throttling.
> > +               Write this file to set current hardware power threshold2 in uW.
> > +               As hardware only accepts values in Watts, so input value will
> > +               be round down per Watts (< 1 watts part will be discarded).
> > +               Write fails with -EINVAL if input parsing fails or input isn't
> > +               in the valid range (0 - 127000000 uW).
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_cap_status
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns 1 if power consumption is currently at or
> > +               above hardware threshold1 (see 'power1_cap'), otherwise 0.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_crit_status
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. It returns 1 if power consumption is currently at or
> > +               above hardware threshold2 (see 'power1_crit'), otherwise 0.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_xeon_limit
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. It returns power limit for XEON in uW.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_fpga_limit
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-Only. It returns power limit for FPGA in uW.
> > +
> > +What:          /sys/bus/platform/devices/dfl-fme.0/hwmon/hwmonX/power1_ltr
> > +Date:          April 2019
> > +KernelVersion: 5.2
> > +Contact:       Wu Hao <hao.wu@intel.com>
> > +Description:   Read-only. Read this file to get current Latency Tolerance
> > +               Reporting (ltr) value. This ltr impacts the CPU low power
> > +               state in integrated solution.
> > diff --git a/drivers/fpga/dfl-fme-main.c b/drivers/fpga/dfl-fme-main.c
> > index b9a68b8..7005316 100644
> > --- a/drivers/fpga/dfl-fme-main.c
> > +++ b/drivers/fpga/dfl-fme-main.c
> > @@ -425,6 +425,249 @@ static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
> >         .uinit = fme_thermal_mgmt_uinit,
> >  };
> >
> > +#define FME_PWR_STATUS         0x8
> > +#define FME_LATENCY_TOLERANCE  BIT_ULL(18)
> > +#define PWR_CONSUMED           GENMASK_ULL(17, 0)
> > +
> > +#define FME_PWR_THRESHOLD      0x10
> > +#define PWR_THRESHOLD1         GENMASK_ULL(6, 0)       /* in Watts */
> > +#define PWR_THRESHOLD2         GENMASK_ULL(14, 8)      /* in Watts */
> > +#define PWR_THRESHOLD_MAX      0x7f                    /* in Watts */
> > +#define PWR_THRESHOLD1_STATUS  BIT_ULL(16)
> > +#define PWR_THRESHOLD2_STATUS  BIT_ULL(17)
> > +
> > +#define FME_PWR_XEON_LIMIT     0x18
> > +#define XEON_PWR_LIMIT         GENMASK_ULL(14, 0)      /* in 0.1 Watts */
> > +#define XEON_PWR_EN            BIT_ULL(15)
> > +#define FME_PWR_FPGA_LIMIT     0x20
> > +#define FPGA_PWR_LIMIT         GENMASK_ULL(14, 0)      /* in 0.1 Watts */
> > +#define FPGA_PWR_EN            BIT_ULL(15)
> > +
> > +#define PWR_THRESHOLD_MAX_IN_UW (PWR_THRESHOLD_MAX * 1000000)
> > +
> > +static int power_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
> > +                           u32 attr, int channel, long *val)
> > +{
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       u64 v;
> > +
> > +       switch (attr) {
> > +       case hwmon_power_input:
> > +               v = readq(feature->ioaddr + FME_PWR_STATUS);
> > +               *val = (long)(FIELD_GET(PWR_CONSUMED, v) * 1000000);
> > +               break;
> > +       case hwmon_power_cap:
> > +               v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> > +               *val = (long)(FIELD_GET(PWR_THRESHOLD1, v) * 1000000);
> > +               break;
> > +       case hwmon_power_crit:
> > +               v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> > +               *val = (long)(FIELD_GET(PWR_THRESHOLD2, v) * 1000000);
> > +               break;
> > +       default:
> > +               return -EOPNOTSUPP;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int power_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
> > +                            u32 attr, int channel, long val)
> > +{
> > +       struct dfl_feature_platform_data *pdata = dev_get_platdata(dev->parent);
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       int ret = 0;
> > +       u64 v;
> > +
> > +       if (val < 0 || val > PWR_THRESHOLD_MAX_IN_UW)
> > +               return -EINVAL;
> > +
> > +       val = val / 1000000;
> > +
> > +       mutex_lock(&pdata->lock);
> > +
> > +       switch (attr) {
> > +       case hwmon_power_cap:
> > +               v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> > +               v &= ~PWR_THRESHOLD1;
> > +               v |= FIELD_PREP(PWR_THRESHOLD1, val);
> > +               writeq(v, feature->ioaddr + FME_PWR_THRESHOLD);
> > +               break;
> > +       case hwmon_power_crit:
> > +               v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> > +               v &= ~PWR_THRESHOLD2;
> > +               v |= FIELD_PREP(PWR_THRESHOLD2, val);
> > +               writeq(v, feature->ioaddr + FME_PWR_THRESHOLD);
> > +               break;
> > +       default:
> > +               ret = -EOPNOTSUPP;
> > +               break;
> > +       }
> > +
> > +       mutex_unlock(&pdata->lock);
> > +
> > +       return ret;
> > +}
> > +
> > +static umode_t power_hwmon_attrs_visible(const void *drvdata,
> > +                                        enum hwmon_sensor_types type,
> > +                                        u32 attr, int channel)
> > +{
> > +       switch (attr) {
> > +       case hwmon_power_input:
> > +               return 0444;
> > +       case hwmon_power_cap:
> > +       case hwmon_power_crit:
> > +               return 0644;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static const u32 power_hwmon_config[] = {
> > +       HWMON_P_INPUT | HWMON_P_CAP | HWMON_P_CRIT,
> > +       0
> > +};
> > +
> > +static const struct hwmon_channel_info hwmon_pwr_info = {
> > +       .type = hwmon_power,
> > +       .config = power_hwmon_config,
> > +};
> > +
> > +static const struct hwmon_channel_info *power_hwmon_info[] = {
> > +       &hwmon_pwr_info,
> > +       NULL
> > +};
> > +
> > +static const struct hwmon_ops power_hwmon_ops = {
> > +       .is_visible = power_hwmon_attrs_visible,
> > +       .read = power_hwmon_read,
> > +       .write = power_hwmon_write,
> > +};
> > +
> > +static const struct hwmon_chip_info power_hwmon_chip_info = {
> > +       .ops = &power_hwmon_ops,
> > +       .info = power_hwmon_info,
> > +};
> > +
> > +static ssize_t power1_cap_status_show(struct device *dev,
> > +                                     struct device_attribute *attr, char *buf)
> > +{
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       u64 v;
> > +
> > +       v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> > +                        (unsigned int)FIELD_GET(PWR_THRESHOLD1_STATUS, v));
> > +}
> > +
> > +static ssize_t power1_crit_status_show(struct device *dev,
> > +                                      struct device_attribute *attr, char *buf)
> > +{
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       u64 v;
> > +
> > +       v = readq(feature->ioaddr + FME_PWR_THRESHOLD);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> > +                        (unsigned int)FIELD_GET(PWR_THRESHOLD2_STATUS, v));
> > +}
> > +
> > +static ssize_t power1_xeon_limit_show(struct device *dev,
> > +                                     struct device_attribute *attr, char *buf)
> > +{
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       u16 xeon_limit = 0;
> > +       u64 v;
> > +
> > +       v = readq(feature->ioaddr + FME_PWR_XEON_LIMIT);
> > +
> > +       if (FIELD_GET(XEON_PWR_EN, v))
> > +               xeon_limit = FIELD_GET(XEON_PWR_LIMIT, v);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n", xeon_limit * 100000);
> > +}
> > +
> > +static ssize_t power1_fpga_limit_show(struct device *dev,
> > +                                     struct device_attribute *attr, char *buf)
> > +{
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       u16 fpga_limit = 0;
> > +       u64 v;
> > +
> > +       v = readq(feature->ioaddr + FME_PWR_FPGA_LIMIT);
> > +
> > +       if (FIELD_GET(FPGA_PWR_EN, v))
> > +               fpga_limit = FIELD_GET(FPGA_PWR_LIMIT, v);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n", fpga_limit * 100000);
> > +}
> > +
> > +static ssize_t power1_ltr_show(struct device *dev,
> > +                              struct device_attribute *attr, char *buf)
> > +{
> > +       struct dfl_feature *feature = dev_get_drvdata(dev);
> > +       u64 v;
> > +
> > +       v = readq(feature->ioaddr + FME_PWR_STATUS);
> > +
> > +       return scnprintf(buf, PAGE_SIZE, "%u\n",
> > +                        (unsigned int)FIELD_GET(FME_LATENCY_TOLERANCE, v));
> > +}
> > +
> > +static DEVICE_ATTR_RO(power1_cap_status);
> > +static DEVICE_ATTR_RO(power1_crit_status);
> > +static DEVICE_ATTR_RO(power1_xeon_limit);
> > +static DEVICE_ATTR_RO(power1_fpga_limit);
> > +static DEVICE_ATTR_RO(power1_ltr);
> > +
> > +static struct attribute *power_extra_attrs[] = {
> > +       &dev_attr_power1_cap_status.attr,
> > +       &dev_attr_power1_crit_status.attr,
> > +       &dev_attr_power1_xeon_limit.attr,
> > +       &dev_attr_power1_fpga_limit.attr,
> > +       &dev_attr_power1_ltr.attr,
> > +       NULL
> > +};
> > +
> > +ATTRIBUTE_GROUPS(power_extra);
> > +
> > +static int fme_power_mgmt_init(struct platform_device *pdev,
> > +                              struct dfl_feature *feature)
> > +{
> > +       struct device *hwmon;
> > +
> > +       dev_dbg(&pdev->dev, "FME Power Management Init.\n");
> > +
> > +       hwmon = devm_hwmon_device_register_with_info(&pdev->dev,
> > +                                                    "dfl_fme_power", feature,
> > +                                                    &power_hwmon_chip_info,
> > +                                                    power_extra_groups);
> > +       if (IS_ERR(hwmon)) {
> > +               dev_err(&pdev->dev, "Fail to register power hwmon\n");
> > +               return PTR_ERR(hwmon);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void fme_power_mgmt_uinit(struct platform_device *pdev,
> > +                                struct dfl_feature *feature)
> > +{
> > +       dev_dbg(&pdev->dev, "FME Power Management UInit.\n");
> > +}
> > +
> > +static const struct dfl_feature_id fme_power_mgmt_id_table[] = {
> > +       {.id = FME_FEATURE_ID_POWER_MGMT,},
> > +       {0,}
> > +};
> > +
> > +static const struct dfl_feature_ops fme_power_mgmt_ops = {
> > +       .init = fme_power_mgmt_init,
> > +       .uinit = fme_power_mgmt_uinit,
> > +};
> > +
> >  static struct dfl_feature_driver fme_feature_drvs[] = {
> >         {
> >                 .id_table = fme_hdr_id_table,
> > @@ -439,6 +682,10 @@ static void fme_thermal_mgmt_uinit(struct platform_device *pdev,
> >                 .ops = &fme_thermal_mgmt_ops,
> >         },
> >         {
> > +               .id_table = fme_power_mgmt_id_table,
> > +               .ops = &fme_power_mgmt_ops,
> > +       },
> > +       {
> >                 .ops = NULL,
> >         },
> >  };
> > --
> > 1.8.3.1
> >
