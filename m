Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1404355D56
	for <lists+linux-fpga@lfdr.de>; Tue,  6 Apr 2021 23:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbhDFVA2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 6 Apr 2021 17:00:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42979 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238037AbhDFVA1 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 6 Apr 2021 17:00:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617742819;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f7cQ1fkEKgqDEs0erixT/rVYD9dx/CspastldTTEa5I=;
        b=AoUgmINL+GFzsXCZutDOHMUSQXvdACMW/EMcy7kQYqRP5Ud7/ubA2dNwYnP32D6kANGkOL
        /07G3V70mtctGXnQFw8Crn7pj2PO3dossFTP4Zs7UDc/OcLHGZsmxMp2fWGH/gPn+7h6iq
        WRgsSOgfvPId8W55ByHzs60Hdt5irtg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-KdfRE-laMRaTu42wJ2TVNw-1; Tue, 06 Apr 2021 17:00:16 -0400
X-MC-Unique: KdfRE-laMRaTu42wJ2TVNw-1
Received: by mail-qk1-f200.google.com with SMTP id g62so13439018qkf.18
        for <linux-fpga@vger.kernel.org>; Tue, 06 Apr 2021 14:00:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f7cQ1fkEKgqDEs0erixT/rVYD9dx/CspastldTTEa5I=;
        b=INpfH4FTLH11uG2mYh8yY53yDsnplA34pr19sjwwlXvkOELKAdpTvo3vTef5xwfbgd
         tHQVFMTW3Zl9nUqoPywqFZPJ7QZGZ+SaUYD1awOKYESjs1v7JQQQMuCukqHWWkggabIY
         VWSwMaI44zIdqJg7h20rWbtcx/QB+NRpiLmRVr1GyqZZAAq/dvv4C4k8dbGh0rISbJ0c
         2PGBlZSFqYA0oIr4IgyseD0GuDvZeh0ChaQKrbfRzkfD96El7tVXiqugrD7WggDa2JSA
         oeVtdcKtqoUZ7vK47GclEgpfHS39HI+vr6vgn0yfCP0YvUN11JuL0J6/s/dolu54bs4z
         eZcA==
X-Gm-Message-State: AOAM532DqEBzsJJXyBwWee9iMAZHRMZjYJoDkZadhL5zPFhnR5Rtf+GO
        Y7Wx1FJvIoguuisppuukPeQN0yst4G4qkZR4WIGJfIyDJa6/B1CO/bMbsMuIHv74tMJsyRJ7JNQ
        rv2Gya7FkWcgnuep/wKNYvw==
X-Received: by 2002:ac8:5156:: with SMTP id h22mr29387532qtn.260.1617742815908;
        Tue, 06 Apr 2021 14:00:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOmy1j35mgzZiFlxS5Jroh61Hm0r4nkBWFryQlZeMfYOuq+cI09SfBZvfmIq6TnDW46tD9gA==
X-Received: by 2002:ac8:5156:: with SMTP id h22mr29387479qtn.260.1617742815257;
        Tue, 06 Apr 2021 14:00:15 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id h16sm15401108qto.45.2021.04.06.14.00.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Apr 2021 14:00:14 -0700 (PDT)
Subject: Re: [PATCH V4 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
 <20210324052947.27889-21-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <26dd81ca-60f7-3ac8-c6a4-69bca4620e8e@redhat.com>
Date:   Tue, 6 Apr 2021 14:00:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210324052947.27889-21-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 3/23/21 10:29 PM, Lizhi Hou wrote:
> Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   MAINTAINERS                        | 11 +++++++++++
>   drivers/Makefile                   |  1 +
>   drivers/fpga/Kconfig               |  2 ++
>   drivers/fpga/Makefile              |  5 +++++
>   drivers/fpga/xrt/Kconfig           |  8 ++++++++
>   drivers/fpga/xrt/lib/Kconfig       | 17 +++++++++++++++++
>   drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++++
>   drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
>   drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
>   drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
>   drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
>   11 files changed, 136 insertions(+)
>   create mode 100644 drivers/fpga/xrt/Kconfig
>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aa84121c5611..44ccc52987ac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7009,6 +7009,17 @@ F:	Documentation/fpga/
>   F:	drivers/fpga/
>   F:	include/linux/fpga/
>   
> +FPGA XRT DRIVERS
> +M:	Lizhi Hou <lizhi.hou@xilinx.com>
> +R:	Max Zhen <max.zhen@xilinx.com>
> +R:	Sonal Santan <sonal.santan@xilinx.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
Should this be 'Supported' ?
> +W:	https://github.com/Xilinx/XRT
> +F:	Documentation/fpga/xrt.rst
> +F:	drivers/fpga/xrt/
> +F:	include/uapi/linux/xrt/
> +
>   FPU EMULATOR
>   M:	Bill Metzenthen <billm@melbpc.org.au>
>   S:	Maintained
> diff --git a/drivers/Makefile b/drivers/Makefile
> index 6fba7daba591..dbb3b727fc7a 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -179,6 +179,7 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
>   obj-$(CONFIG_ANDROID)		+= android/
>   obj-$(CONFIG_NVMEM)		+= nvmem/
>   obj-$(CONFIG_FPGA)		+= fpga/
> +obj-$(CONFIG_FPGA_XRT_METADATA) += fpga/
CONFIG_FPGA_XRT_METADATA is only defined when CONFIG_FPGA is, so i don't 
think this line is needed.
>   obj-$(CONFIG_FSI)		+= fsi/
>   obj-$(CONFIG_TEE)		+= tee/
>   obj-$(CONFIG_MULTIPLEXER)	+= mux/
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5ff9438b7b46..01410ff000b9 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -227,4 +227,6 @@ config FPGA_MGR_ZYNQMP_FPGA
>   	  to configure the programmable logic(PL) through PS
>   	  on ZynqMP SoC.
>   
> +source "drivers/fpga/xrt/Kconfig"
> +
>   endif # FPGA
This is where it is defined..
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885883a..4b887bf95cb3 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -48,3 +48,8 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>   
>   # Drivers for FPGAs which implement DFL
>   obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +
> +# XRT drivers for Alveo
> +obj-$(CONFIG_FPGA_XRT_METADATA)		+= xrt/metadata/
> +obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
> +obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/
> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> new file mode 100644
> index 000000000000..0e2c59589ddd
> --- /dev/null
> +++ b/drivers/fpga/xrt/Kconfig
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Xilinx Alveo FPGA device configuration
> +#
> +
> +source "drivers/fpga/xrt/metadata/Kconfig"
> +source "drivers/fpga/xrt/lib/Kconfig"
> +source "drivers/fpga/xrt/mgmt/Kconfig"
> diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
> new file mode 100644
> index 000000000000..935369fad570
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/Kconfig
> @@ -0,0 +1,17 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# XRT Alveo FPGA device configuration
> +#
> +
> +config FPGA_XRT_LIB
> +	tristate "XRT Alveo Driver Library"
> +	depends on HWMON && PCI && HAS_IOMEM
> +	select FPGA_XRT_METADATA
> +	select REGMAP_MMIO
> +	help
> +	  Select this option to enable Xilinx XRT Alveo driver library. This
> +	  library is core infrastructure of XRT Alveo FPGA drivers which
> +	  provides functions for working with device nodes, iteration and
> +	  lookup of platform devices, common interfaces for platform devices,
> +	  plumbing of function call and ioctls between platform devices and
> +	  parent partitions.
> diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
> new file mode 100644
> index 000000000000..58563416efbf
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/Makefile
> @@ -0,0 +1,30 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Sonal.Santan@xilinx.com
> +#
> +
> +FULL_XRT_PATH=$(srctree)/$(src)/..
> +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
> +
> +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
> +
> +xrt-lib-objs :=			\
> +	lib-drv.o		\
> +	xroot.o			\
> +	xclbin.o		\
> +	subdev.o		\
> +	cdev.o			\
> +	group.o			\
> +	xleaf/vsec.o		\
> +	xleaf/axigate.o		\
> +	xleaf/devctl.o		\
> +	xleaf/icap.o		\
> +	xleaf/clock.o		\
> +	xleaf/clkfreq.o		\
> +	xleaf/ucs.o		\
> +	xleaf/ddr_calibration.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include	 \
> +	-I$(FULL_DTC_PATH)
> diff --git a/drivers/fpga/xrt/metadata/Kconfig b/drivers/fpga/xrt/metadata/Kconfig
> new file mode 100644
> index 000000000000..129adda47e94
> --- /dev/null
> +++ b/drivers/fpga/xrt/metadata/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# XRT Alveo FPGA device configuration
> +#
> +
> +config FPGA_XRT_METADATA
> +	bool "XRT Alveo Driver Metadata Parser"
> +	select LIBFDT
> +	help
> +	  This option provides helper functions to parse Xilinx Alveo FPGA
> +	  firmware metadata. The metadata is in device tree format and the
> +	  XRT driver uses it to discover the HW subsystems behind PCIe BAR.
> diff --git a/drivers/fpga/xrt/metadata/Makefile b/drivers/fpga/xrt/metadata/Makefile
> new file mode 100644
> index 000000000000..14f65ef1595c
> --- /dev/null
> +++ b/drivers/fpga/xrt/metadata/Makefile
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Sonal.Santan@xilinx.com
> +#
> +
> +FULL_XRT_PATH=$(srctree)/$(src)/..
> +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
> +
> +obj-$(CONFIG_FPGA_XRT_METADATA) += xrt-md.o
> +
> +xrt-md-objs := metadata.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include	\
> +	-I$(FULL_DTC_PATH)
> diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
> new file mode 100644
> index 000000000000..31e9e19fffb8
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Xilinx XRT FPGA device configuration
> +#
> +
> +config FPGA_XRT_XMGMT
> +	tristate "Xilinx Alveo Management Driver"
> +	depends on FPGA_XRT_LIB
> +	select FPGA_XRT_METADATA

If the XRT driver depends on these other two configs and it does not 
make sense to build these two seperately, could you remove these configs 
and just use something like FPGA_XRT ?

Tom

> +	select FPGA_BRIDGE
> +	select FPGA_REGION
> +	help
> +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> +	  This driver provides interfaces for userspace application to access
> +	  Alveo FPGA device.
> diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
> new file mode 100644
> index 000000000000..acabd811f3fd
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/Makefile
> @@ -0,0 +1,19 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Sonal.Santan@xilinx.com
> +#
> +
> +FULL_XRT_PATH=$(srctree)/$(src)/..
> +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
> +
> +obj-$(CONFIG_FPGA_XRT_XMGMT)	+= xrt-mgmt.o
> +
> +xrt-mgmt-objs := root.o		\
> +	   main.o		\
> +	   fmgr-drv.o		\
> +	   main-region.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include		\
> +	-I$(FULL_DTC_PATH)

