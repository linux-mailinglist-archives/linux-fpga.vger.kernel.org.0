Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB5C320B2F
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 15:59:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbhBUO7G (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 09:59:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:22692 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229817AbhBUO7F (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 21 Feb 2021 09:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613919457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2befxLu2IQxO43e65gbS8ljrIpOf1REtIzhaumemsBs=;
        b=LZY6deYZk9ue5wmcfnQBsxuhIRQQEz1QAC46vCzwyZRQKpzWCVjUDg6HlSBCDAG0bxk0Wn
        7OVpIo5V3XXbrOGuyXnXKrCfiWQ4v8pnbFWpZBbqOBLmJj6/CHhiPasCzzg7TYCgcWpBp5
        UC9ViJJTGJLhDfshFyTWHVdR+888VaM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-RgZdBqhjMEKQYOgs7Fu4LQ-1; Sun, 21 Feb 2021 09:57:35 -0500
X-MC-Unique: RgZdBqhjMEKQYOgs7Fu4LQ-1
Received: by mail-qk1-f197.google.com with SMTP id e65so2315236qkf.20
        for <linux-fpga@vger.kernel.org>; Sun, 21 Feb 2021 06:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2befxLu2IQxO43e65gbS8ljrIpOf1REtIzhaumemsBs=;
        b=ujnaF+n+kB5y4ShoNHA6dsyhV2Zs2Vm6HYaN1wifxoGB7KSXW1sQfpoFax2iymLAO5
         TXFnTPMROizY3E8sDvZs1mjpBPIq+pmJE/ijsFck3OAp4Gf7sev+J82rh4ba035SbKmy
         RkllFk+MvFH5Un9yIMjAEdRV1Vq0hy5ZG0o0eAXhvhayahDfe4CHFBkjTuko3XIZ9ZMS
         Z/GEEA8vIzveqxHrBZunDKCdJPOL0riU1MF8gkvBRIv0Gp14pVK7qTtNJKp5tuwcCcF3
         E/DFrbBmMZCEuYFt3Q+s/OuAYrC7NdZJf+aHvOqeq9mYwmAaM2df3TCC+ekzmxNXLVTa
         yWfA==
X-Gm-Message-State: AOAM530MkizDqBFJ4WlqyH+u5/bMSXMj+pRuquIh9Tbwm4E7oOV5ODlP
        +WJ7GUX3nfubSG2ytu7/NZM/SRD1Us76ZUWCC30+iM8rtLRtroleiY2DMjYNrqf6V99G5GO9x64
        r9hJTo69ugfgCGhXPJ0qIww==
X-Received: by 2002:a0c:f510:: with SMTP id j16mr9413609qvm.61.1613919454392;
        Sun, 21 Feb 2021 06:57:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy1M5cNMTqFUqOPWG72zbGBl5rmWXEQ+hX6IVHdj22jB+26MYa7yveQ5COgKJj/TeS/SMQpmg==
X-Received: by 2002:a0c:f510:: with SMTP id j16mr9413599qvm.61.1613919454106;
        Sun, 21 Feb 2021 06:57:34 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id q3sm10461625qkb.73.2021.02.21.06.57.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Feb 2021 06:57:33 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 18/18] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        "mdf@kernel.org" <mdf@kernel.org>
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-19-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <287d9c6b-1b2b-f62d-ff8a-ad57b01f58a6@redhat.com>
Date:   Sun, 21 Feb 2021 06:57:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-19-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

As I am looking through the files, I have this comment.

fpga/ is currently a single directory, while files could be organized in subdirectories like

dfl/pci.c

instead have the possible subdir name as a prefix to the filename.

dfl-pci.c

For consistency,

xrt/metadata/metadata.c

should be

xrt-metadata.c

Likewise the build infra needs to integrated within the existing files fpga/Kconfig,Makefile

This is a bigish refactor, so let's get a second opinion.

Moritz ?

On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers.
Expand the comment, there are several new configs that could use an explanation
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  MAINTAINERS                        | 11 +++++++++++
>  drivers/Makefile                   |  1 +
>  drivers/fpga/Kconfig               |  2 ++
>  drivers/fpga/Makefile              |  4 ++++
>  drivers/fpga/xrt/Kconfig           |  8 ++++++++
>  drivers/fpga/xrt/lib/Kconfig       | 16 ++++++++++++++++
>  drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++++
>  drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
>  drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
>  drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
>  drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
>  11 files changed, 134 insertions(+)
>  create mode 100644 drivers/fpga/xrt/Kconfig
>  create mode 100644 drivers/fpga/xrt/lib/Kconfig
>  create mode 100644 drivers/fpga/xrt/lib/Makefile
>  create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>  create mode 100644 drivers/fpga/xrt/metadata/Makefile
>  create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>  create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d3e847f7f3dc..e6e147c2454c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6973,6 +6973,17 @@ F:	Documentation/fpga/
>  F:	drivers/fpga/
>  F:	include/linux/fpga/
>  
> +FPGA XRT DRIVERS
> +M:	Lizhi Hou <lizhi.hou@xilinx.com>
> +R:	Max Zhen <max.zhen@xilinx.com>
> +R:	Sonal Santan <sonal.santan@xilinx.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Maintained
> +W:	https://github.com/Xilinx/XRT
> +F:	Documentation/fpga/xrt.rst
> +F:	drivers/fpga/xrt/
> +F:	include/uapi/linux/xrt/
> +
>  FPU EMULATOR
>  M:	Bill Metzenthen <billm@melbpc.org.au>
>  S:	Maintained
> diff --git a/drivers/Makefile b/drivers/Makefile
> index fd11b9ac4cc3..e03912af8e48 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -178,6 +178,7 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
>  obj-$(CONFIG_ANDROID)		+= android/
>  obj-$(CONFIG_NVMEM)		+= nvmem/
>  obj-$(CONFIG_FPGA)		+= fpga/
> +obj-y				+= fpga/xrt/metadata/

This is wrong.

Move metadata building to fpga/ Makefile and pick an appropriate config, not just 'obj-y'

>  obj-$(CONFIG_FSI)		+= fsi/
>  obj-$(CONFIG_TEE)		+= tee/
>  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 5645226ca3ce..aeca635b1f25 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -216,4 +216,6 @@ config FPGA_MGR_ZYNQMP_FPGA
>  	  to configure the programmable logic(PL) through PS
>  	  on ZynqMP SoC.
>  
> +source "drivers/fpga/xrt/Kconfig"
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index d8e21dfc6778..2b4453ff7c52 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -46,3 +46,7 @@ dfl-afu-objs += dfl-afu-error.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +
> +# XRT drivers for Alveo
> +obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
> +obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/

I don't see how mgmnt would work without lib.  If that is so

these configs could collapse to CONFIG_FPGA_XRT

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
> index 000000000000..eed5cb73f5e2
> --- /dev/null
> +++ b/drivers/fpga/xrt/lib/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# XRT Alveo FPGA device configuration
> +#
> +
> +config FPGA_XRT_LIB
> +	tristate "XRT Alveo Driver Library"
> +	depends on HWMON && PCI && HAS_IOMEM
> +	select FPGA_XRT_METADATA
> +	help
> +	  Select this option to enable Xilinx XRT Alveo driver library. This
> +	  library is core infrastructure of XRT Alveo FPGA drivers which
> +	  provides functions for working with device nodes, iteration and
> +	  lookup of platform devices, common interfaces for platform devices,
> +	  plumbing of function call and ioctls between platform devices and
> +	  parent partitions.
> diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
> new file mode 100644
> index 000000000000..5641231b2a36
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
> +	main.o			\
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
> +	xleaf/calib.o		\
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include	 \
> +	-I$(FULL_DTC_PATH)
> diff --git a/drivers/fpga/xrt/metadata/Kconfig b/drivers/fpga/xrt/metadata/Kconfig
> new file mode 100644
> index 000000000000..5012c9c6584d
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
> +	  firmware metadata. The metadata is in device tree format and XRT
and the XRT
> +	  driver uses it to discover HW subsystems behind PCIe BAR.
the HW
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
> index 000000000000..2b2a2c34685c
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
> +	depends on HWMON && PCI && FPGA_XRT_LIB

FPGA_XRT_LIB also depends on HWMON and PCI, so this could be minimized.

Tom

> +	select FPGA_XRT_METADATA
> +	select FPGA_BRIDGE
> +	select FPGA_REGION
> +	help
> +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> +	  This driver provides interfaces for userspace application to access
> +	  Alveo FPGA device.
> diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
> new file mode 100644
> index 000000000000..8051708c361c
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
> +obj-$(CONFIG_FPGA_XRT_XMGMT)	+= xmgmt.o
> +
> +xmgmt-objs := root.o		\
> +	   main.o		\
> +	   fmgr-drv.o		\
> +	   main-region.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include		\
> +	-I$(FULL_DTC_PATH)

