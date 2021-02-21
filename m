Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90AC0320CB5
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 19:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhBUSk0 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 13:40:26 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:34017 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbhBUSkW (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Feb 2021 13:40:22 -0500
Received: by mail-pl1-f181.google.com with SMTP id ba1so6227121plb.1;
        Sun, 21 Feb 2021 10:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=k2g72g8h3qyLt+0ix02hwfytzFr14WUM97H/GKT0hJQ=;
        b=B4Qoo/eABqRMY1/WR89Q81NIsnlqmPURQBvwsn/CxWbNWxdF1vM5ffoFWSFWbropBu
         jE84tCfjUGvUskkYD8/iK12V+Rp6ynv8Uh9sqRH0hBCKL2Rgu8z0/MKPtJnly2NcXovX
         HNDgVNN9NKKjwZ1ptWCubZK1mE/51H+7FA0L/s2llPMyR85g/TbA5OmncFkCFI2Jk86x
         fKZZ9xcUJ0rBbqsyRKUQrdY4TLe4nOz8bXdrgXhubGX0C4l7/5dG041tKeGf/Njk/b9B
         13mZV20/8CdMho7FxRdQLIT53m2NdADz16o0xHqv+ReZGJ013tGc9LWIPqKNAFZhFgn2
         SvKQ==
X-Gm-Message-State: AOAM5330KxItz0Vl+abUbTqxlOTKIIIm72TcRYJ+brV/w8GqNnV2WoNe
        muLtIlIII/DhhB9Er6qvxijpcYVNprKUJg==
X-Google-Smtp-Source: ABdhPJwTIlVQh9YtMIcHYNBuLM9rtr7KUA0kptaOgPszWMG4z4/LoLkVhO9/JGtAXnGsJN3XM2qfkg==
X-Received: by 2002:a17:90a:62c1:: with SMTP id k1mr19180133pjs.79.1613932781922;
        Sun, 21 Feb 2021 10:39:41 -0800 (PST)
Received: from localhost ([2601:647:5b00:1161:a4cc:eef9:fbc0:2781])
        by smtp.gmail.com with ESMTPSA id a9sm14782221pjq.17.2021.02.21.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 10:39:41 -0800 (PST)
Date:   Sun, 21 Feb 2021 10:39:40 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        "mdf@kernel.org" <mdf@kernel.org>, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, robh@kernel.org,
        Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V3 XRT Alveo 18/18] fpga: xrt: Kconfig and Makefile
 updates for XRT drivers
Message-ID: <YDKo7KiLm9ajkC67@epycbox.lan>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-19-lizhih@xilinx.com>
 <287d9c6b-1b2b-f62d-ff8a-ad57b01f58a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <287d9c6b-1b2b-f62d-ff8a-ad57b01f58a6@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sun, Feb 21, 2021 at 06:57:31AM -0800, Tom Rix wrote:
> As I am looking through the files, I have this comment.
> 
> fpga/ is currently a single directory, while files could be organized in subdirectories like
> 
> dfl/pci.c
> 
> instead have the possible subdir name as a prefix to the filename.
> 
> dfl-pci.c
> 
> For consistency,
> 
> xrt/metadata/metadata.c
> 
> should be
> 
> xrt-metadata.c

Agreed. Keep the prefix.
> 
> Likewise the build infra needs to integrated within the existing files fpga/Kconfig,Makefile
> 
> This is a bigish refactor, so let's get a second opinion.

In what sense? You mean adding a subdirectory? Maybe something like this

drivers/fpga
  - dfl/
  - xilinx/
  - intel/
  - lattice/
  - xrt/
  ...

would generally make sense.

We didn't have enough drivers to prioritize that yet, but we can look
into it.
> 
> Moritz ?
> 
> On 2/17/21 10:40 PM, Lizhi Hou wrote:
> > Update fpga Kconfig/Makefile and add Kconfig/Makefile for new drivers.
> Expand the comment, there are several new configs that could use an explanation
> >
> > Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> > Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> > Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> > ---
> >  MAINTAINERS                        | 11 +++++++++++
> >  drivers/Makefile                   |  1 +
> >  drivers/fpga/Kconfig               |  2 ++
> >  drivers/fpga/Makefile              |  4 ++++
> >  drivers/fpga/xrt/Kconfig           |  8 ++++++++
> >  drivers/fpga/xrt/lib/Kconfig       | 16 ++++++++++++++++
> >  drivers/fpga/xrt/lib/Makefile      | 30 ++++++++++++++++++++++++++++++
> >  drivers/fpga/xrt/metadata/Kconfig  | 12 ++++++++++++
> >  drivers/fpga/xrt/metadata/Makefile | 16 ++++++++++++++++
> >  drivers/fpga/xrt/mgmt/Kconfig      | 15 +++++++++++++++
> >  drivers/fpga/xrt/mgmt/Makefile     | 19 +++++++++++++++++++
> >  11 files changed, 134 insertions(+)
> >  create mode 100644 drivers/fpga/xrt/Kconfig
> >  create mode 100644 drivers/fpga/xrt/lib/Kconfig
> >  create mode 100644 drivers/fpga/xrt/lib/Makefile
> >  create mode 100644 drivers/fpga/xrt/metadata/Kconfig
> >  create mode 100644 drivers/fpga/xrt/metadata/Makefile
> >  create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
> >  create mode 100644 drivers/fpga/xrt/mgmt/Makefile
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index d3e847f7f3dc..e6e147c2454c 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6973,6 +6973,17 @@ F:	Documentation/fpga/
> >  F:	drivers/fpga/
> >  F:	include/linux/fpga/
> >  
> > +FPGA XRT DRIVERS
> > +M:	Lizhi Hou <lizhi.hou@xilinx.com>
> > +R:	Max Zhen <max.zhen@xilinx.com>
> > +R:	Sonal Santan <sonal.santan@xilinx.com>
> > +L:	linux-fpga@vger.kernel.org
> > +S:	Maintained
> > +W:	https://github.com/Xilinx/XRT
> > +F:	Documentation/fpga/xrt.rst
> > +F:	drivers/fpga/xrt/
> > +F:	include/uapi/linux/xrt/
> > +
> >  FPU EMULATOR
> >  M:	Bill Metzenthen <billm@melbpc.org.au>
> >  S:	Maintained
> > diff --git a/drivers/Makefile b/drivers/Makefile
> > index fd11b9ac4cc3..e03912af8e48 100644
> > --- a/drivers/Makefile
> > +++ b/drivers/Makefile
> > @@ -178,6 +178,7 @@ obj-$(CONFIG_STM)		+= hwtracing/stm/
> >  obj-$(CONFIG_ANDROID)		+= android/
> >  obj-$(CONFIG_NVMEM)		+= nvmem/
> >  obj-$(CONFIG_FPGA)		+= fpga/
> > +obj-y				+= fpga/xrt/metadata/
> 
> This is wrong.
> 
> Move metadata building to fpga/ Makefile and pick an appropriate config, not just 'obj-y'
> 
> >  obj-$(CONFIG_FSI)		+= fsi/
> >  obj-$(CONFIG_TEE)		+= tee/
> >  obj-$(CONFIG_MULTIPLEXER)	+= mux/
> > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > index 5645226ca3ce..aeca635b1f25 100644
> > --- a/drivers/fpga/Kconfig
> > +++ b/drivers/fpga/Kconfig
> > @@ -216,4 +216,6 @@ config FPGA_MGR_ZYNQMP_FPGA
> >  	  to configure the programmable logic(PL) through PS
> >  	  on ZynqMP SoC.
> >  
> > +source "drivers/fpga/xrt/Kconfig"
> > +
> >  endif # FPGA
> > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > index d8e21dfc6778..2b4453ff7c52 100644
> > --- a/drivers/fpga/Makefile
> > +++ b/drivers/fpga/Makefile
> > @@ -46,3 +46,7 @@ dfl-afu-objs += dfl-afu-error.o
> >  
> >  # Drivers for FPGAs which implement DFL
> >  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> > +
> > +# XRT drivers for Alveo
> > +obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
> > +obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/
> 
> I don't see how mgmnt would work without lib.  If that is so
> 
> these configs could collapse to CONFIG_FPGA_XRT
> 
> > diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> > new file mode 100644
> > index 000000000000..0e2c59589ddd
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/Kconfig
> > @@ -0,0 +1,8 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Xilinx Alveo FPGA device configuration
> > +#
> > +
> > +source "drivers/fpga/xrt/metadata/Kconfig"
> > +source "drivers/fpga/xrt/lib/Kconfig"
> > +source "drivers/fpga/xrt/mgmt/Kconfig"
> > diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
> > new file mode 100644
> > index 000000000000..eed5cb73f5e2
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/Kconfig
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# XRT Alveo FPGA device configuration
> > +#
> > +
> > +config FPGA_XRT_LIB
> > +	tristate "XRT Alveo Driver Library"
> > +	depends on HWMON && PCI && HAS_IOMEM
> > +	select FPGA_XRT_METADATA
> > +	help
> > +	  Select this option to enable Xilinx XRT Alveo driver library. This
> > +	  library is core infrastructure of XRT Alveo FPGA drivers which
> > +	  provides functions for working with device nodes, iteration and
> > +	  lookup of platform devices, common interfaces for platform devices,
> > +	  plumbing of function call and ioctls between platform devices and
> > +	  parent partitions.
> > diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
> > new file mode 100644
> > index 000000000000..5641231b2a36
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/lib/Makefile
> > @@ -0,0 +1,30 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> > +#
> > +# Authors: Sonal.Santan@xilinx.com
> > +#
> > +
> > +FULL_XRT_PATH=$(srctree)/$(src)/..
> > +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
> > +
> > +obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
> > +
> > +xrt-lib-objs :=			\
> > +	main.o			\
> > +	xroot.o			\
> > +	xclbin.o		\
> > +	subdev.o		\
> > +	cdev.o			\
> > +	group.o			\
> > +	xleaf/vsec.o		\
> > +	xleaf/axigate.o		\
> > +	xleaf/devctl.o		\
> > +	xleaf/icap.o		\
> > +	xleaf/clock.o		\
> > +	xleaf/clkfreq.o		\
> > +	xleaf/ucs.o		\
> > +	xleaf/calib.o		\
> > +
> > +ccflags-y := -I$(FULL_XRT_PATH)/include	 \
> > +	-I$(FULL_DTC_PATH)
> > diff --git a/drivers/fpga/xrt/metadata/Kconfig b/drivers/fpga/xrt/metadata/Kconfig
> > new file mode 100644
> > index 000000000000..5012c9c6584d
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/metadata/Kconfig
> > @@ -0,0 +1,12 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# XRT Alveo FPGA device configuration
> > +#
> > +
> > +config FPGA_XRT_METADATA
> > +	bool "XRT Alveo Driver Metadata Parser"
> > +	select LIBFDT
> > +	help
> > +	  This option provides helper functions to parse Xilinx Alveo FPGA
> > +	  firmware metadata. The metadata is in device tree format and XRT
> and the XRT
> > +	  driver uses it to discover HW subsystems behind PCIe BAR.
> the HW
> > diff --git a/drivers/fpga/xrt/metadata/Makefile b/drivers/fpga/xrt/metadata/Makefile
> > new file mode 100644
> > index 000000000000..14f65ef1595c
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/metadata/Makefile
> > @@ -0,0 +1,16 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> > +#
> > +# Authors: Sonal.Santan@xilinx.com
> > +#
> > +
> > +FULL_XRT_PATH=$(srctree)/$(src)/..
> > +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
> > +
> > +obj-$(CONFIG_FPGA_XRT_METADATA) += xrt-md.o
> > +
> > +xrt-md-objs := metadata.o
> > +
> > +ccflags-y := -I$(FULL_XRT_PATH)/include	\
> > +	-I$(FULL_DTC_PATH)
> > diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
> > new file mode 100644
> > index 000000000000..2b2a2c34685c
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/mgmt/Kconfig
> > @@ -0,0 +1,15 @@
> > +# SPDX-License-Identifier: GPL-2.0-only
> > +#
> > +# Xilinx XRT FPGA device configuration
> > +#
> > +
> > +config FPGA_XRT_XMGMT
> > +	tristate "Xilinx Alveo Management Driver"
> > +	depends on HWMON && PCI && FPGA_XRT_LIB
> 
> FPGA_XRT_LIB also depends on HWMON and PCI, so this could be minimized.
> 
> Tom
> 
> > +	select FPGA_XRT_METADATA
> > +	select FPGA_BRIDGE
> > +	select FPGA_REGION
> > +	help
> > +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> > +	  This driver provides interfaces for userspace application to access
> > +	  Alveo FPGA device.
> > diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
> > new file mode 100644
> > index 000000000000..8051708c361c
> > --- /dev/null
> > +++ b/drivers/fpga/xrt/mgmt/Makefile
> > @@ -0,0 +1,19 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +#
> > +# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
> > +#
> > +# Authors: Sonal.Santan@xilinx.com
> > +#
> > +
> > +FULL_XRT_PATH=$(srctree)/$(src)/..
> > +FULL_DTC_PATH=$(srctree)/scripts/dtc/libfdt
> > +
> > +obj-$(CONFIG_FPGA_XRT_XMGMT)	+= xmgmt.o
> > +
> > +xmgmt-objs := root.o		\
> > +	   main.o		\
> > +	   fmgr-drv.o		\
> > +	   main-region.o
> > +
> > +ccflags-y := -I$(FULL_XRT_PATH)/include		\
> > +	-I$(FULL_DTC_PATH)
> 

- Moritz
