Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6182329AA0F
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Oct 2020 11:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421682AbgJ0Kyg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Oct 2020 06:54:36 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:41804 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1421670AbgJ0Kyf (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 27 Oct 2020 06:54:35 -0400
Received: by mail-ej1-f66.google.com with SMTP id s15so1539884ejf.8;
        Tue, 27 Oct 2020 03:54:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JjtWj9MeDxgzy3cyYzlZ7UXTJFUzUFCRq9qsHTzTSWw=;
        b=lwu/fOjlEPp8jUP/hbmQ0KTgHJ1FHuVsMdb6iqdxYxk2OicvtJhPeOcI1Bd/vjI9Iz
         dQ1ZIyCYGB/IGW7wmaOIoAA8IA3sd0v0NhPJvswtz6wPUDE70RJNtoWDpskgFot7AQTM
         bo1Ob+IJuuDPDU0UtfZlEAQv0uQrEbfTwGCDBjKxQwSzyrWndefDbLco2Wl1Vgm8+Qo7
         ArDUxxPkcxFWyYIB25eI1dDuB++bBy+CrNHCIqk4tmkqHF46Q9H6DOyagMB68OuFltX+
         mKifJkXcOSy5o3w6Sy0NYwODEuDO0JYo9EkYBzh01bVDwwlakYk24r8Q9kEB/dFaGNgD
         amqQ==
X-Gm-Message-State: AOAM5324G55p3X+K8Ke5Ij96vElPWIFpCxtMJXyI/nM4YM/zCeeI1W82
        ztbIDU7OQyie2DmVMeVDncM=
X-Google-Smtp-Source: ABdhPJyomBmF5eNWUlWzPCNL41gp5z17F0jQLsUFZXJvYCe9zXxfBsI/xicn2ikkh3hSgiPeOHOtbg==
X-Received: by 2002:a17:906:11d3:: with SMTP id o19mr1701103eja.287.1603796071913;
        Tue, 27 Oct 2020 03:54:31 -0700 (PDT)
Received: from kozik-lap ([194.230.155.184])
        by smtp.googlemail.com with ESMTPSA id by10sm694397edb.86.2020.10.27.03.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 03:54:30 -0700 (PDT)
Date:   Tue, 27 Oct 2020 11:54:27 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        trix@redhat.com, lgoncalv@redhat.com, hao.wu@intel.com,
        Matthew Gerlach <matthew.gerlach@linux.intel.com>,
        Russ Weight <russell.h.weight@intel.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v11 1/2] fpga: dfl: add support for N3000 Nios private
 feature
Message-ID: <20201027105427.GA20676@kozik-lap>
References: <1603790581-4487-1-git-send-email-yilun.xu@intel.com>
 <1603790581-4487-2-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1603790581-4487-2-git-send-email-yilun.xu@intel.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Oct 27, 2020 at 05:23:00PM +0800, Xu Yilun wrote:
> This patch adds support for the Nios handshake private feature on Intel
> PAC (Programmable Acceleration Card) N3000.
> 
> The Nios is the embedded processor on the FPGA card. This private feature
> provides a handshake interface to FPGA Nios firmware, which receives
> retimer configuration command from host and executes via an internal SPI
> master (spi-altera). When Nios finishes the configuration, host takes over
> the ownership of the SPI master to control an Intel MAX10 BMC (Board
> Management Controller) Chip on the SPI bus.
> 
> For Nios firmware handshake part, this driver requests the retimer
> configuration for Nios firmware on probe, and adds some sysfs nodes for
> user to query the onboard retimer's working mode and Nios firmware
> version.
> 
> For SPI part, this driver adds a spi-altera platform device as well as
> the MAX10 BMC spi slave info. A spi-altera driver will be matched to
> handle the following SPI work.
> 
> [mdf@kernel.org: Fixed up MAINTAINERS file to include added ABI doc]
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v3: add the doc for this driver
>     minor fixes for comments from Tom
> v4: move the err log in regmap implementation, and delete
>      n3000_nios_writel/readl(), they have nothing to wrapper now.
>     some minor fixes and comments improvement.
> v5: fix the output of fec_mode sysfs inf to "no" on 10G configuration,
>      cause no FEC mode could be configured for 10G.
>     rename the dfl_n3000_nios_* to n3000_nios_*
>     improves comments.
> v6: fix the output of fec_mode sysfs inf to "not supported" if in 10G,
>      or the firmware version major < 3.
>     minor fixes and improves comments.
> v7: improves comments.
> v8: add sysfs interfaces for retimer mode, also doc update.
>     delete duplicated sysfs interfaces description in doc.
>     minor fixes.
> v9: delete the retimer FEC mode configuration via module_parameter.
>     update the kernel version of the sysfs interfaces in Doc.
>     merge the patch "Make m10_n3000_info static" (https://lore.kernel.org/linux-fpga/52d8411e-13d8-1e91-756d-131802f5f445@huawei.com/T/#t)
>     remove the tags of Maintainers, this implementation is changed.
> v10: improve the name of some macros, functions and variables.
>      refactor the FEC mode setting and reading.
>      refactor the retimer init error checking and dumping.
>      refactor the loop timeout for regbus reading & write.
>      some minor fixes.
> v11: use sysfs_emit instead of sprintf.
>      rebase to 5.10-rc1.
> ---
>  .../ABI/testing/sysfs-bus-dfl-devices-n3000-nios   |  47 ++
>  MAINTAINERS                                        |   2 +-
>  drivers/fpga/Kconfig                               |  11 +
>  drivers/fpga/Makefile                              |   2 +
>  drivers/fpga/dfl-n3000-nios.c                      | 588 +++++++++++++++++++++
>  5 files changed, 649 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
>  create mode 100644 drivers/fpga/dfl-n3000-nios.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> new file mode 100644
> index 0000000..a505537
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-dfl-devices-n3000-nios
> @@ -0,0 +1,47 @@
> +What:		/sys/bus/dfl/devices/dfl_dev.X/fec_mode
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. Returns the FEC mode of the 25G links of the
> +		ethernet retimers configured by Nios firmware. "rs" for Reed
> +		Solomon FEC, "kr" for Fire Code FEC, "no" for NO FEC.
> +		"not supported" if the FEC mode setting is not supported, this
> +		happens when the Nios firmware version major < 3, or no link is
> +		configured to 25G.
> +		Format: string
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/retimer_A_mode
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. Returns the enumeration value of the working mode of
> +		the retimer A configured by the Nios firmware. The value is
> +		read out from shared registers filled by the Nios firmware. Now
> +		the values could be:
> +
> +		- "0": Reset
> +		- "1": 4x10G
> +		- "2": 4x25G
> +		- "3": 2x25G
> +		- "4": 2x25G+2x10G
> +		- "5": 1x25G
> +
> +		If the Nios firmware is updated in future to support more
> +		retimer modes, more enumeration value is expected.
> +		Format: 0x%x
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/retimer_B_mode
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. Returns the enumeration value of the working mode of
> +		the retimer B configured by the Nios firmware. The value format
> +		is the same as retimer_A_mode.
> +
> +What:		/sys/bus/dfl/devices/dfl_dev.X/nios_fw_version
> +Date:		Oct 2020
> +KernelVersion:	5.11
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read-only. Returns the version of the Nios firmware in the
> +		FPGA. Its format is "major.minor.patch".
> +		Format: %x.%x.%x
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9bbb378..bedb18d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6883,7 +6883,7 @@ M:	Wu Hao <hao.wu@intel.com>
>  R:	Tom Rix <trix@redhat.com>
>  L:	linux-fpga@vger.kernel.org
>  S:	Maintained
> -F:	Documentation/ABI/testing/sysfs-bus-dfl
> +F:	Documentation/ABI/testing/sysfs-bus-dfl*
>  F:	Documentation/fpga/dfl.rst
>  F:	drivers/fpga/dfl*
>  F:	include/linux/dfl.h
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29..5d7f0ae 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -191,6 +191,17 @@ config FPGA_DFL_AFU
>  	  to the FPGA infrastructure via a Port. There may be more than one
>  	  Port/AFU per DFL based FPGA device.
>  
> +config FPGA_DFL_NIOS_INTEL_PAC_N3000
> +	tristate "FPGA DFL NIOS Driver for Intel PAC N3000"
> +	depends on FPGA_DFL
> +	select REGMAP
> +	help
> +	  This is the driver for the N3000 Nios private feature on Intel
> +	  PAC (Programmable Acceleration Card) N3000. It communicates
> +	  with the embedded Nios processor to configure the retimers on
> +	  the card. It also instantiates the SPI master (spi-altera) for
> +	  the card's BMC (Board Management Controller).
> +

(...)

> +{
> +	struct n3000_nios *nn = dev_get_drvdata(&ddev->dev);
> +
> +	destroy_altera_spi_controller(nn);
> +}
> +
> +#define FME_FEATURE_ID_N3000_NIOS	0xd
> +
> +static const struct dfl_device_id n3000_nios_ids[] = {
> +	{ FME_ID, FME_FEATURE_ID_N3000_NIOS },
> +	{ }
> +};

Why isn't here a module device table?

Best regards,
Krzysztof

> +
> +static struct dfl_driver n3000_nios_driver = {
> +	.drv	= {
> +		.name       = "dfl-n3000-nios",
> +		.dev_groups = n3000_nios_groups,
> +	},
> +	.id_table = n3000_nios_ids,
> +	.probe   = n3000_nios_probe,
> +	.remove  = n3000_nios_remove,
> +};
> +
> +module_dfl_driver(n3000_nios_driver);
> +
> +MODULE_DEVICE_TABLE(dfl, n3000_nios_ids);
> +MODULE_DESCRIPTION("Driver for Nios private feature on Intel PAC N3000");
> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.7.4
> 
