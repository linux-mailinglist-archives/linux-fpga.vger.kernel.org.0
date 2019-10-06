Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4325CD2E9
	for <lists+linux-fpga@lfdr.de>; Sun,  6 Oct 2019 17:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfJFPcN (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 6 Oct 2019 11:32:13 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46029 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfJFPcN (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 6 Oct 2019 11:32:13 -0400
Received: by mail-pg1-f194.google.com with SMTP id q7so6623613pgi.12;
        Sun, 06 Oct 2019 08:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MWnh2NkSggRpWJ1Tjr/K4BWiLmJNlO3/w2a2XHt2eJ4=;
        b=QSF5zFhsMmnOdjA7oiiqCYuTRhZTj6ymjURSiD0BXxgBy5Gk/BApaWHj+PK32xbCnL
         LlWi2dLSt5RqzfyFgfbxKqhdW++mUXUkwDkEDzAKao3mvpYjeFL665Y6xOkvGUcGFoGE
         T8N983bTBWKP1awDVCI6F2m7LWzep7zNJuEI+7qon4P3GzrVNQy2CxhSMTWSg9736KUC
         7cAAIMeVjifuOviXw1JDNqIiRHth8LY8fi5sD881fUsaQioK2VlDJLdn8bGMdPf53b8+
         YPZDGnMmuoB5olnm/gSksVGPSWreMcfAc52Pa8M5IJ8ikYs977mLvVQJP29VlptS6LUl
         RUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=MWnh2NkSggRpWJ1Tjr/K4BWiLmJNlO3/w2a2XHt2eJ4=;
        b=Pk76xfjpDJUimvx2zVyrqspnkMj+EUeUhB+177SjAFuclLmRMRl8wKX6HvwyIrspbD
         l2PzoiVUv3PUBwWcO4CZj3oY3TjMIUVIEM3Q06etOQcMXVHOD5Kf0GN8UykjeZ1ntAg1
         nas1oXprHt6cM+kJa9Pw9D7PcDP93Po4aFQyNcKismYBJObD51MuZzaHdmdz0yJxQRoy
         GWGockpauVb7gzoUY6W/e0hKzREO7Vlb5Y0NB/Rla+pUKKcE/7/vev1OHcaaOOYjItcf
         uWJoSEg/fLn8qmJKfyctINIBrWaf+76m8eLwg/mY4jOaIX0AQmcFjsgOKFPS+ZYKjRJr
         EGWQ==
X-Gm-Message-State: APjAAAWGyuIiSrrMoUBSTBIpnlFIxHLIkmH+4NFg0IURY9ZNSa+BlaFS
        mHLDDmtEL69oPtPGlXJQhlo=
X-Google-Smtp-Source: APXvYqz390mtfjvyr4HAYGQXx0I5DsX8kSFnk7tWnF+Lq7gSvJyEuklZu16aKH5dMYpyqZqE0zhUyg==
X-Received: by 2002:a63:175c:: with SMTP id 28mr3600902pgx.300.1570375930765;
        Sun, 06 Oct 2019 08:32:10 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i16sm12848693pfa.184.2019.10.06.08.32.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 06 Oct 2019 08:32:10 -0700 (PDT)
Date:   Sun, 6 Oct 2019 08:32:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     devicetree@vger.kernel.org, linux-fpga@vger.kernel.org,
        linux-hwmon@vger.kernel.org, Moritz Fischer <mdf@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 2/3] hwmon: Support ADI Fan Control IP
Message-ID: <20191006153209.GA30372@roeck-us.net>
References: <20190926103925.194973-1-nuno.sa@analog.com>
 <20190926103925.194973-3-nuno.sa@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190926103925.194973-3-nuno.sa@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Thu, Sep 26, 2019 at 12:39:24PM +0200, Nuno Sá wrote:
> The purpose of this IP Core is to control the fan used for the cooling of a
> Xilinx Zynq Ultrascale+ MPSoC without the need of any external temperature
> sensors. To achieve this, the IP core uses the PL SYSMONE4 primitive to
> obtain the PL temperature and, based on those readings, it then outputs
> a PWM signal to control the fan rotation accordingly.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
>  MAINTAINERS                     |   7 +
>  drivers/hwmon/Kconfig           |   9 +
>  drivers/hwmon/Makefile          |   1 +
>  drivers/hwmon/axi-fan-control.c | 452 ++++++++++++++++++++++++++++++++
>  4 files changed, 469 insertions(+)
>  create mode 100644 drivers/hwmon/axi-fan-control.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c7035ce2460b..d775c923d23b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2853,6 +2853,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/sound/axentia,*
>  F:	sound/soc/atmel/tse850-pcm5142.c
>  
> +AXI-FAN-CONTROL HARDWARE MONITOR DRIVER
> +M:	Nuno Sá <nuno.sa@analog.com>
> +W:	http://ez.analog.com/community/linux-device-drivers
> +L:	linux-hwmon@vger.kernel.org
> +S:	Supported
> +F:	drivers/hwmon/axi-fan-control.c
> +
>  AXXIA I2C CONTROLLER
>  M:	Krzysztof Adamski <krzysztof.adamski@nokia.com>
>  L:	linux-i2c@vger.kernel.org
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 2ca5668bdb62..2396cc347c47 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -269,6 +269,15 @@ config SENSORS_ASC7621
>  	  This driver can also be built as a module. If so, the module
>  	  will be called asc7621.
>  
> +config SENSORS_AXI_FAN_CONTROL
> +	tristate "Analog Devices FAN Control HDL Core driver"
> +	help
> +	  If you say yes here you get support for the Analog Devices
> +	  AXI HDL FAN monitoring core.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called axi-fan-control
> +
>  config SENSORS_K8TEMP
>  	tristate "AMD Athlon64/FX or Opteron temperature sensor"
>  	depends on X86 && PCI
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index c86ce4d3d36b..ebb1fd2ea82b 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -51,6 +51,7 @@ obj-$(CONFIG_SENSORS_AS370)	+= as370-hwmon.o
>  obj-$(CONFIG_SENSORS_ASC7621)	+= asc7621.o
>  obj-$(CONFIG_SENSORS_ASPEED)	+= aspeed-pwm-tacho.o
>  obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
> +obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
> diff --git a/drivers/hwmon/axi-fan-control.c b/drivers/hwmon/axi-fan-control.c
> new file mode 100644
> index 000000000000..f86efc444753
> --- /dev/null
> +++ b/drivers/hwmon/axi-fan-control.c
> @@ -0,0 +1,452 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Fan Control HDL CORE driver
> + *
> + * Copyright 2019 Analog Devices Inc.
> + */
> +#include <linux/clk.h>
> +#include <linux/fpga/adi-axi-common.h>
> +#include <linux/hwmon.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +
> +/* register map */
> +#define ADI_REG_RSTN		0x0080
> +#define ADI_REG_PWM_WIDTH	0x0084
> +#define ADI_REG_TACH_PERIOD	0x0088
> +#define ADI_REG_TACH_TOLERANCE	0x008c
> +#define ADI_REG_PWM_PERIOD	0x00c0
> +#define ADI_REG_TACH_MEASUR	0x00c4
> +#define ADI_REG_TEMPERATURE	0x00c8
> +
> +#define ADI_REG_IRQ_MASK	0x0040
> +#define ADI_REG_IRQ_PENDING	0x0044
> +#define ADI_REG_IRQ_SRC		0x0048
> +
> +/* IRQ sources */
> +#define ADI_IRQ_SRC_PWM_CHANGED		BIT(0)

include linux/bits.h

> +#define ADI_IRQ_SRC_TACH_ERR		BIT(1)
> +#define ADI_IRQ_SRC_TEMP_INCREASE	BIT(2)
> +#define ADI_IRQ_SRC_NEW_MEASUR		BIT(3)
> +#define ADI_IRQ_SRC_MASK		GENMASK(3, 0)
> +#define ADI_IRQ_MASK_OUT_ALL		0xFFFFFFFFU
> +
> +#define SYSFS_PWM_MAX			255
> +
> +struct axi_fan_control_data {
> +	struct clk *clk;
> +	void __iomem *base;
> +	/* tacho period */
> +	atomic_t tach;

Why exactly is this an atomic ? The value is only set, and it is set in
a single operation. Why does it matter if reqading it catches the old or
the new value ?

> +	int irq;
> +	/* pulses per revolution */
> +	u32 ppr;
> +	bool hw_pwm_req;
> +	bool update_tacho_params;
> +	u8 fan_fault;
> +};
> +
> +static inline void axi_fan_control_iowrite(const u32 val, const u32 reg,
> +				const struct axi_fan_control_data *ctl)

Multi-line alignment. Also, please consider shorter function names.
An "axi_fan_control_" prefix for static functions is really a bit excessive
and doesn't add value. "axi_" would do it just as well.

> +{
> +	iowrite32(val, ctl->base + reg);
> +}
> +
> +static inline u32 axi_fan_control_ioread(const u32 reg,
> +					 const struct axi_fan_control_data *ctl)
> +{
> +	return ioread32(ctl->base + reg);
> +}
> +
> +static long axi_fan_control_get_pwm_duty(const struct axi_fan_control_data *ctl)
> +{
> +	u32 pwm_width = axi_fan_control_ioread(ADI_REG_PWM_WIDTH, ctl);
> +	u32 pwm_period = axi_fan_control_ioread(ADI_REG_PWM_PERIOD, ctl);
> +
> +	return DIV_ROUND_CLOSEST(pwm_width * SYSFS_PWM_MAX, pwm_period);

Is pwm_period guaranteed to be != 0 ?

> +}
> +
> +static int axi_fan_control_set_pwm_duty(const long val,
> +					struct axi_fan_control_data *ctl)
> +{
> +	u32 pwm_period = axi_fan_control_ioread(ADI_REG_PWM_PERIOD, ctl);
> +	u32 new_width;
> +	long __val = clamp_val(val, 0, SYSFS_PWM_MAX);
> +
> +	new_width = DIV_ROUND_CLOSEST(__val * pwm_period, SYSFS_PWM_MAX);
> +
> +	axi_fan_control_iowrite(new_width, ADI_REG_PWM_WIDTH, ctl);
> +
> +	return 0;
> +}
> +
> +static long axi_fan_control_get_fan_rpm(const struct axi_fan_control_data *ctl)
> +{
> +	unsigned long clk_rate = clk_get_rate(ctl->clk);
> +
> +	if (!clk_rate)
> +		return -EINVAL;

Unless the clock rate changes dynamically, it might make sense to read it once
in the probe function.

> +	/*
> +	 * The tacho period should be:
> +	 *      TACH = 60/(ppr * rpm), where rpm is revolutions per second
> +	 *      and ppr is pulses per revolution.
> +	 * Given the tacho period, we can multiply it by the input clock
> +	 * so that we know how many clocks we need to have this period.
> +	 * From this, we can derive the RPM value.
> +	 */
> +	return DIV_ROUND_CLOSEST(60 * clk_rate,
> +				 ctl->ppr * atomic_read(&ctl->tach));

Are ppr and tach guaranteed to be != 0 ? I don't think so,
since neither is ever evaluated.

> +}
> +
> +static int axi_fan_control_read_temp(struct device *dev, u32 attr, long *val)
> +{
> +	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
> +	long raw_temp;
> +
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		raw_temp = axi_fan_control_ioread(ADI_REG_TEMPERATURE, ctl);
> +		/*
> +		 * The formula for the temperature is:
> +		 *      T = (ADC * 501.3743 / 2^bits) - 273.6777
> +		 * It's multiplied by 1000 to have milidegrees as

s/milidegrees/millidegrees/

> +		 * specified by the hwmon sysfs interface.
> +		 */
> +		*val = ((raw_temp * 501374) >> 16) - 273677;
> +		return 0;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int axi_fan_control_read_fan(struct device *dev, u32 attr, long *val)
> +{
> +	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_fan_fault:
> +		*val = ctl->fan_fault;
> +		return 0;
> +	case hwmon_fan_input:
> +		*val = axi_fan_control_get_fan_rpm(ctl);
> +		return 0;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int axi_fan_control_read_pwm(struct device *dev, u32 attr, long *val)
> +{
> +	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		*val = axi_fan_control_get_pwm_duty(ctl);
> +		return 0;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int axi_fan_control_write_pwm(struct device *dev, u32 attr, long val)
> +{
> +	struct axi_fan_control_data *ctl = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		return axi_fan_control_set_pwm_duty(val, ctl);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int axi_fan_control_read_labels(struct device *dev,
> +				       enum hwmon_sensor_types type,
> +				       u32 attr, int channel, const char **str)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		*str = "FAN";
> +		return 0;
> +	case hwmon_temp:
> +		*str = "SYSMON4";
> +		return 0;
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int axi_fan_control_read(struct device *dev,
> +				enum hwmon_sensor_types type,
> +				u32 attr, int channel, long *val)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return axi_fan_control_read_fan(dev, attr, val);
> +	case hwmon_pwm:
> +		return axi_fan_control_read_pwm(dev, attr, val);
> +	case hwmon_temp:
> +		return axi_fan_control_read_temp(dev, attr, val);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static int axi_fan_control_write(struct device *dev,
> +				 enum hwmon_sensor_types type,
> +				 u32 attr, int channel, long val)
> +{
> +	switch (type) {
> +	case hwmon_pwm:
> +		return axi_fan_control_write_pwm(dev, attr, val);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static umode_t axi_fan_control_fan_is_visible(const u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_fan_input:
> +	case hwmon_fan_fault:
> +	case hwmon_fan_label:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static umode_t axi_fan_control_pwm_is_visible(const u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static umode_t axi_fan_control_temp_is_visible(const u32 attr)
> +{
> +	switch (attr) {
> +	case hwmon_temp_input:
> +	case hwmon_temp_label:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static umode_t axi_fan_control_is_visible(const void *data,
> +					  enum hwmon_sensor_types type,
> +					  u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_fan:
> +		return axi_fan_control_fan_is_visible(attr);
> +	case hwmon_pwm:
> +		return axi_fan_control_pwm_is_visible(attr);
> +	case hwmon_temp:
> +		return axi_fan_control_temp_is_visible(attr);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static irqreturn_t axi_fan_control_irq_handler(int irq, void *data)
> +{
> +	struct axi_fan_control_data *ctl = (struct axi_fan_control_data *)data;
> +	u32 irq_pending = axi_fan_control_ioread(ADI_REG_IRQ_PENDING, ctl);
> +	u32 clear_mask;
> +
> +	if (irq_pending & ADI_IRQ_SRC_NEW_MEASUR) {
> +		u32 new_tach = axi_fan_control_ioread(ADI_REG_TACH_MEASUR,
> +						      ctl);
> +
> +		if (ctl->update_tacho_params) {
> +			/* get 25% tolerance */
> +			u32 tach_tol = DIV_ROUND_CLOSEST(new_tach * 25, 100);
> +			/* set new tacho parameters */
> +			axi_fan_control_iowrite(new_tach, ADI_REG_TACH_PERIOD,
> +						ctl);
> +			axi_fan_control_iowrite(tach_tol,
> +						ADI_REG_TACH_TOLERANCE, ctl);
> +			ctl->update_tacho_params = false;
> +		}
> +
> +		atomic_set(&ctl->tach, new_tach);
> +	}
> +
> +	if (irq_pending & ADI_IRQ_SRC_PWM_CHANGED) {
> +		/*
> +		 * if the pwm changes on behalf of software,
> +		 * we need to provide new tacho parameters to the core.
> +		 * Wait for the next measurement for that...
> +		 */
> +		if (!ctl->hw_pwm_req)
> +			ctl->update_tacho_params = true;
> +
> +		/* just set this to false even if it is already... */
> +		ctl->hw_pwm_req = false;
> +	}
> +
> +	if (irq_pending & ADI_IRQ_SRC_TEMP_INCREASE)
> +		/* hardware requested a new pwm */
> +		ctl->hw_pwm_req = true;
> +
I don't really understand the logic here. If ADI_IRQ_SRC_TEMP_INCREASE means
that hardware wants a new pwm, how is userspace informed about that request ?
And why are the tacho paramaters _not_ updated in this case later on (unless
ADI_IRQ_SRC_PWM_CHANGED and ADI_IRQ_SRC_TEMP_INCREASE are both set) ?
It might be useful to describe the expected sequence of events.

> +	if (irq_pending & ADI_IRQ_SRC_TACH_ERR)
> +		ctl->fan_fault = 1;

Is it on purpose that this bit is never reset ?

> +
> +	/* clear all interrupts */
> +	clear_mask = irq_pending & ADI_IRQ_SRC_MASK;
> +	axi_fan_control_iowrite(clear_mask, ADI_REG_IRQ_PENDING, ctl);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int axi_fan_control_init(struct axi_fan_control_data *ctl,
> +				const struct device_node *np)
> +{
> +	int ret;
> +
> +	/* get fan pulses per revolution */
> +	ret = of_property_read_u32(np, "adi,pulses-per-revolution", &ctl->ppr);
> +	if (ret)
> +		return ret;

So all random values are acceptable, including 0 and 0xffffffff ?

> +	/*
> +	 * Enable all IRQs
> +	 */
> +	axi_fan_control_iowrite((ADI_IRQ_MASK_OUT_ALL &
> +			~(ADI_IRQ_SRC_NEW_MEASUR | ADI_IRQ_SRC_TACH_ERR |
> +			ADI_IRQ_SRC_PWM_CHANGED | ADI_IRQ_SRC_TEMP_INCREASE)),

One set of ( ) is unnecessary.

> +			ADI_REG_IRQ_MASK, ctl);
> +
> +	/* bring the device out of reset */
> +	axi_fan_control_iowrite(0x01, ADI_REG_RSTN, ctl);
> +
> +	return ret;
> +}
> +
> +static const struct hwmon_channel_info *axi_fan_control_info[] = {
> +	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT),
> +	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT | HWMON_F_FAULT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_LABEL),
> +	NULL
> +};
> +
> +static const struct hwmon_ops axi_fan_control_hwmon_ops = {
> +	.is_visible = axi_fan_control_is_visible,
> +	.read = axi_fan_control_read,
> +	.write = axi_fan_control_write,
> +	.read_string = axi_fan_control_read_labels,
> +};
> +
> +static const struct hwmon_chip_info axi_fan_control_chip_info = {
> +	.ops = &axi_fan_control_hwmon_ops,
> +	.info = axi_fan_control_info,
> +};
> +
> +static const u32 version_1_0_0 = ADI_AXI_PCORE_VER(1, 0, 'a');
> +
> +static const struct of_device_id axi_fan_control_of_match[] = {
> +	{ .compatible = "adi,axi-fan-control-1.00.a",
> +		.data = (void *)&version_1_0_0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, axi_fan_control_of_match);
> +
> +static int axi_fan_control_probe(struct platform_device *pdev)
> +{
> +	struct device *hwmon_dev;
> +	struct axi_fan_control_data *ctl;
> +	const struct of_device_id *id;
> +	struct resource *res;
> +	u32 version;
> +	int ret;
> +
> +	id = of_match_node(axi_fan_control_of_match, pdev->dev.of_node);
> +	if (!id)
> +		return -EINVAL;
> +
> +	ctl = devm_kzalloc(&pdev->dev, sizeof(*ctl), GFP_KERNEL);
> +	if (!ctl)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	ctl->base = devm_ioremap_resource(&pdev->dev, res);

devm_platform_ioremap_resource()

> +	if (IS_ERR(ctl->base)) {
> +		dev_err(&pdev->dev, "ioremap failed with %ld\n",
> +			PTR_ERR(ctl->base));
> +		return PTR_ERR(ctl->base);
> +	}

This does not require an extra error message.

> +
> +	ctl->clk = devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ctl->clk)) {
> +		dev_err(&pdev->dev, "clk_get failed with %ld\n",
> +			PTR_ERR(ctl->clk));
> +		return PTR_ERR(ctl->clk);
> +	}
> +
> +	dev_dbg(&pdev->dev, "Re-mapped from 0x%08llX to %p\n",
> +		(unsigned long long)res->start, ctl->base);
> +
> +	version = axi_fan_control_ioread(ADI_AXI_REG_VERSION, ctl);
> +	if (ADI_AXI_PCORE_VER_MAJOR(version) !=
> +	    ADI_AXI_PCORE_VER_MAJOR((*(u32 *)id->data))) {
> +		dev_err(&pdev->dev, "Major version mismatch. Expected %d.%.2d.%c, Reported %d.%.2d.%c\n",
> +			ADI_AXI_PCORE_VER_MAJOR((*(u32 *)id->data)),
> +			ADI_AXI_PCORE_VER_MINOR((*(u32 *)id->data)),
> +			ADI_AXI_PCORE_VER_PATCH((*(u32 *)id->data)),
> +			ADI_AXI_PCORE_VER_MAJOR(version),
> +			ADI_AXI_PCORE_VER_MINOR(version),
> +			ADI_AXI_PCORE_VER_PATCH(version));
> +		return -ENODEV;
> +	}
> +
> +	ctl->irq = platform_get_irq(pdev, 0);
> +	if (ctl->irq < 0) {

This can return -EPROBE_DEFER. On top of that, it already generates an error
message, meaning another one here is unnecessary.

> +		dev_err(&pdev->dev, "platform_get_irq failed with %d\n",
> +			ctl->irq);
> +		return ctl->irq;
> +	}
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, ctl->irq, NULL,
> +					axi_fan_control_irq_handler,
> +					IRQF_ONESHOT | IRQF_TRIGGER_HIGH,
> +					pdev->driver_override, ctl);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to request an irq, %d", ret);
> +		return ret;
> +	}
> +
> +	ret = axi_fan_control_init(ctl, pdev->dev.of_node);
> +	if (ret) {
> +		dev_err(&pdev->dev, "Failed to initialize device\n");
> +		return ret;
> +	}
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
> +						"axi_fan_control",
> +						ctl,
> +						&axi_fan_control_chip_info,
> +						NULL);

Another alignment issue. Shorter function and global variable names would help.

> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static struct platform_driver axi_fan_control_driver = {
> +	.driver = {
> +		.name = "axi_fan_control_driver",
> +		.of_match_table = axi_fan_control_of_match,
> +	},
> +	.probe = axi_fan_control_probe,
> +};
> +module_platform_driver(axi_fan_control_driver);
> +
> +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices Fan Control HDL CORE driver");
> +MODULE_LICENSE("GPL");
> -- 
> 2.23.0
> 
