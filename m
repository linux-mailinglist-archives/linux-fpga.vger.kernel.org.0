Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38A00372BD9
	for <lists+linux-fpga@lfdr.de>; Tue,  4 May 2021 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhEDOTc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 4 May 2021 10:19:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42860 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231411AbhEDOTc (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 4 May 2021 10:19:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620137917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9x/77yeyXeNZvJjVtaYZPWVz/OnUb0ueLIClLRnQJU=;
        b=fbaNEmj962jpPa5BKRxwU+AOthi0DGRRryN8F43HqXXQPVq/xv9cRgeTkqK90CHh4mxB+p
        1/Pd7ntsX2SvOYyHSUVIySnM6EycOpE1nfP5bUf7R+ZUxGgbg6+EZEAi40ZYBoOuNHsuHk
        CSB8wTxpKbfRA+58mIcZLyRetm/4bwI=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-9u-WIrZUNE28P_WMhtm74w-1; Tue, 04 May 2021 10:18:34 -0400
X-MC-Unique: 9u-WIrZUNE28P_WMhtm74w-1
Received: by mail-qv1-f72.google.com with SMTP id g26-20020a0caada0000b02901b93eb92373so7717016qvb.3
        for <linux-fpga@vger.kernel.org>; Tue, 04 May 2021 07:18:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f9x/77yeyXeNZvJjVtaYZPWVz/OnUb0ueLIClLRnQJU=;
        b=YX8hcQ9VmILxCbJACIvwe4Qnbv8wraEdTqhAP5X/p8MFFB5J40eAnrdj25fZEoPrnf
         wpz0IgCrb6R85q6ugn2frzm+KZ3HCJ85BMwk59uS0zWQvDL+L63HwKfEBYIs/13Ad2HE
         BlM1O8oYsEJ/4zA8mkzSnjoAhmJJj3crhUkCi26aVXQv6WIH9kLwKiTBLPhE6vG3ERB3
         3fcIwX/zC8aYovdzYlwRJIRF4mPJa2ejQwaH+xY4tYYrIlHOMEfKzuy1ak3I2KTODsz8
         ll1yNYzoKj/UXTYgDiECzp14I1Xy9YMFj/OUTeW7huQLG5y7FsAMqKSY62sRTTOOP60k
         5t2A==
X-Gm-Message-State: AOAM532IVosyo+v5LKvgn0ftZih/s323K8LEnZdKmUM9jP4fGYA8/2Mm
        pAxri/RlIXrYHhJIzYeQBEouL+On02aPqgQLnLAfKqiMFfZqcHSDN+XQp/QGKTN6+BxwmVXB9xF
        hFdfeUgUx3T4KuBOUHQ+tgw==
X-Received: by 2002:ad4:4aa4:: with SMTP id i4mr25871833qvx.29.1620137914205;
        Tue, 04 May 2021 07:18:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDmj2UYYr5px8bgya2gUq3bzQCyQIGFWEqcKsTlSsi8fQb5Gb63VZ8ZH8Uwna+VC550sb5rA==
X-Received: by 2002:ad4:4aa4:: with SMTP id i4mr25871796qvx.29.1620137913999;
        Tue, 04 May 2021 07:18:33 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id v65sm11496017qkc.125.2021.05.04.07.18.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 May 2021 07:18:33 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 20/20] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
 <20210427205431.23896-21-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <237222b7-13bc-55d3-b77e-6fc07e691dff@redhat.com>
Date:   Tue, 4 May 2021 07:18:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-21-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
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
>   drivers/fpga/xrt/mgnt/Kconfig      | 15 +++++++++++++++
>   drivers/fpga/xrt/mgnt/Makefile     | 19 +++++++++++++++++++
>   11 files changed, 136 insertions(+)
>   create mode 100644 drivers/fpga/xrt/Kconfig
>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>   create mode 100644 drivers/fpga/xrt/mgnt/Kconfig
>   create mode 100644 drivers/fpga/xrt/mgnt/Makefile
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9450e052f1b1..89abe140041b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7016,6 +7016,17 @@ F:	Documentation/fpga/
>   F:	drivers/fpga/
>   F:	include/linux/fpga/
>   
> +FPGA XRT DRIVERS
> +M:	Lizhi Hou <lizhi.hou@xilinx.com>
> +R:	Max Zhen <max.zhen@xilinx.com>
> +R:	Sonal Santan <sonal.santan@xilinx.com>
> +L:	linux-fpga@vger.kernel.org
> +S:	Supported
ok
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
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 18dc9885883a..a1cad7f7af09 100644
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
> +obj-$(CONFIG_FPGA_XRT_XMGNT)		+= xrt/mgnt/
> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> new file mode 100644
> index 000000000000..2424f89e6e03
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
> +source "drivers/fpga/xrt/mgnt/Kconfig"
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
ok
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
ok
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
> diff --git a/drivers/fpga/xrt/mgnt/Kconfig b/drivers/fpga/xrt/mgnt/Kconfig
> new file mode 100644
> index 000000000000..b43242c14757
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgnt/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Xilinx XRT FPGA device configuration
> +#
> +
> +config FPGA_XRT_XMGNT
> +	tristate "Xilinx Alveo Management Driver"
> +	depends on FPGA_XRT_LIB
> +	select FPGA_XRT_METADATA
> +	select FPGA_BRIDGE
> +	select FPGA_REGION
> +	help
> +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> +	  This driver provides interfaces for userspace application to access
> +	  Alveo FPGA device.

ok

good enough for now.

Reviewed-by: Tom Rix <trix@redhat.com>

> diff --git a/drivers/fpga/xrt/mgnt/Makefile b/drivers/fpga/xrt/mgnt/Makefile
> new file mode 100644
> index 000000000000..b71d2ff0aa94
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgnt/Makefile
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
> +obj-$(CONFIG_FPGA_XRT_XMGNT)	+= xrt-mgnt.o
> +
> +xrt-mgnt-objs := root.o		\
> +	   xmgnt-main.o		\
> +	   xrt-mgr.o		\
> +	   xmgnt-main-region.o
> +
> +ccflags-y := -I$(FULL_XRT_PATH)/include		\
> +	-I$(FULL_DTC_PATH)

