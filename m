Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C43103A92F7
	for <lists+linux-fpga@lfdr.de>; Wed, 16 Jun 2021 08:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbhFPGqV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 16 Jun 2021 02:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:35710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhFPGqU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 16 Jun 2021 02:46:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3688461246;
        Wed, 16 Jun 2021 06:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623825855;
        bh=sRHL++P1LvtKqbrnBqUPwL8n12zn0Ypnp0DTwnZUriY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRAWuRAZtqyO7vfC1QkEpH+IsDYhm/GX5lb7VGhggfKOKWhP9JftTetpySEvbUMLq
         gA2b5tqh+2smQvnAM3PFbk4QOyYxIvDbfgR8IqRCyjsqW3/u0uwjW0YbuyqtHf1/vU
         MEcbywTDDPAjW/AMAeYmvxOUXwD/SbnfjKWli2T4=
Date:   Wed, 16 Jun 2021 08:44:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     hao.wu@intel.com, mdf@kernel.org, corbet@lwn.net,
        michal.simek@xilinx.com, krzysztof.kozlowski@canonical.com,
        nava.manne@xilinx.com, yilun.xu@intel.com, davidgow@google.com,
        fpacheco@redhat.com, richard.gong@intel.com, luca@lucaceresoli.net,
        linux-fpga@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 2/4] fpga: xilinx: reorganize to subdir layout
Message-ID: <YMmdu2tBZn7BE88J@kroah.com>
References: <20210614201648.3358206-1-trix@redhat.com>
 <20210614201648.3358206-4-trix@redhat.com>
 <YMhYfCgOAthEqPXs@kroah.com>
 <4fa2a233-e429-1b41-fc9b-1f4c6d9a05ae@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fa2a233-e429-1b41-fc9b-1f4c6d9a05ae@redhat.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Tue, Jun 15, 2021 at 01:19:11PM -0700, Tom Rix wrote:
> 
> On 6/15/21 12:36 AM, Greg KH wrote:
> > On Mon, Jun 14, 2021 at 01:16:46PM -0700, trix@redhat.com wrote:
> > > From: Tom Rix <trix@redhat.com>
> > > 
> > > Follow drivers/net/ethernet/ which has control configs
> > > NET_VENDOR_BLA that map to drivers/net/ethernet/bla
> > > Since fpgas do not have many vendors, drop the 'VENDOR' and use
> > > FPGA_BLA.
> > > 
> > > There are several new subdirs
> > > altera/
> > > dfl/
> > > lattice/
> > > xilinx/
> > > 
> > > Each subdir has a Kconfig that has a new/reused
> > > 
> > > if FPGA_BLA
> > >    ... existing configs ...
> > > endif FPGA_BLA
> > > 
> > > Which is sourced into the main fpga/Kconfig
> > > 
> > > Each subdir has a Makefile whose transversal is controlled in the
> > > fpga/Makefile by
> > > 
> > > obj-$(CONFIG_FPGA_BLA) += bla/
> > > 
> > > This is the xilinx/ subdir part
> > > 
> > > Create a xilinx/ subdir
> > > Move xilinx-* and zynq* files to it.
> > > Add a Kconfig and Makefile
> > > 
> > > Signed-off-by: Tom Rix <trix@redhat.com>
> > > ---
> > >   drivers/fpga/Kconfig                          | 40 +-------------
> > >   drivers/fpga/Makefile                         |  5 +-
> > >   drivers/fpga/xilinx/Kconfig                   | 55 +++++++++++++++++++
> > >   drivers/fpga/xilinx/Makefile                  |  6 ++
> > >   .../fpga/{ => xilinx}/xilinx-pr-decoupler.c   |  0
> > >   drivers/fpga/{ => xilinx}/xilinx-spi.c        |  0
> > >   drivers/fpga/{ => xilinx}/zynq-fpga.c         |  0
> > >   drivers/fpga/{ => xilinx}/zynqmp-fpga.c       |  0
> > >   8 files changed, 63 insertions(+), 43 deletions(-)
> > >   create mode 100644 drivers/fpga/xilinx/Kconfig
> > >   create mode 100644 drivers/fpga/xilinx/Makefile
> > >   rename drivers/fpga/{ => xilinx}/xilinx-pr-decoupler.c (100%)
> > >   rename drivers/fpga/{ => xilinx}/xilinx-spi.c (100%)
> > >   rename drivers/fpga/{ => xilinx}/zynq-fpga.c (100%)
> > >   rename drivers/fpga/{ => xilinx}/zynqmp-fpga.c (100%)
> > > 
> > > diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> > > index 7a290b2234576..28c261807b428 100644
> > > --- a/drivers/fpga/Kconfig
> > > +++ b/drivers/fpga/Kconfig
> > > @@ -52,25 +52,12 @@ config FPGA_MGR_ALTERA_CVP
> > >   	  FPGA manager driver support for Arria-V, Cyclone-V, Stratix-V,
> > >   	  Arria 10 and Stratix10 Altera FPGAs using the CvP interface over PCIe.
> > > -config FPGA_MGR_ZYNQ_FPGA
> > > -	tristate "Xilinx Zynq FPGA"
> > > -	depends on ARCH_ZYNQ || COMPILE_TEST
> > > -	help
> > > -	  FPGA manager driver support for Xilinx Zynq FPGAs.
> > > -
> > >   config FPGA_MGR_STRATIX10_SOC
> > >   	tristate "Intel Stratix10 SoC FPGA Manager"
> > >   	depends on (ARCH_INTEL_SOCFPGA && INTEL_STRATIX10_SERVICE)
> > >   	help
> > >   	  FPGA manager driver support for the Intel Stratix10 SoC.
> > > -config FPGA_MGR_XILINX_SPI
> > > -	tristate "Xilinx Configuration over Slave Serial (SPI)"
> > > -	depends on SPI
> > > -	help
> > > -	  FPGA manager driver support for Xilinx FPGA configuration
> > > -	  over slave serial interface.
> > > -
> > >   config FPGA_MGR_ICE40_SPI
> > >   	tristate "Lattice iCE40 SPI"
> > >   	depends on OF && SPI
> > > @@ -113,23 +100,6 @@ config ALTERA_FREEZE_BRIDGE
> > >   	  isolate one region of the FPGA from the busses while that
> > >   	  region is being reprogrammed.
> > > -config XILINX_PR_DECOUPLER
> > > -	tristate "Xilinx LogiCORE PR Decoupler"
> > > -	depends on FPGA_BRIDGE
> > > -	depends on HAS_IOMEM
> > > -	help
> > > -	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
> > > -	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
> > > -	  The PR Decoupler exists in the FPGA fabric to isolate one
> > > -	  region of the FPGA from the busses while that region is
> > > -	  being reprogrammed during partial reconfig.
> > > -	  The Dynamic Function eXchange AXI shutdown manager prevents
> > > -	  AXI traffic from passing through the bridge. The controller
> > > -	  safely handles AXI4MM and AXI4-Lite interfaces on a
> > > -	  Reconfigurable Partition when it is undergoing dynamic
> > > -	  reconfiguration, preventing the system deadlock that can
> > > -	  occur if AXI transactions are interrupted by DFX.
> > > -
> > >   config FPGA_REGION
> > >   	tristate "FPGA Region"
> > >   	depends on FPGA_BRIDGE
> > > @@ -146,14 +116,6 @@ config OF_FPGA_REGION
> > >   	  overlay.
> > >   source "drivers/fpga/dfl/Kconfig"
> > > -
> > > -config FPGA_MGR_ZYNQMP_FPGA
> > > -	tristate "Xilinx ZynqMP FPGA"
> > > -	depends on ZYNQMP_FIRMWARE || (!ZYNQMP_FIRMWARE && COMPILE_TEST)
> > > -	help
> > > -	  FPGA manager driver support for Xilinx ZynqMP FPGAs.
> > > -	  This driver uses the processor configuration port(PCAP)
> > > -	  to configure the programmable logic(PL) through PS
> > > -	  on ZynqMP SoC.
> > > +source "drivers/fpga/xilinx/Kconfig"
> > >   endif # FPGA
> > > diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> > > index bda74e54ce390..0868c7c4264d8 100644
> > > --- a/drivers/fpga/Makefile
> > > +++ b/drivers/fpga/Makefile
> > > @@ -15,9 +15,6 @@ obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
> > >   obj-$(CONFIG_FPGA_MGR_SOCFPGA_A10)	+= socfpga-a10.o
> > >   obj-$(CONFIG_FPGA_MGR_STRATIX10_SOC)	+= stratix10-soc.o
> > >   obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
> > > -obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
> > > -obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
> > > -obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
> > >   obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
> > >   obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> > > @@ -25,10 +22,10 @@ obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
> > >   obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
> > >   obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
> > >   obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
> > > -obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
> > >   # High Level Interfaces
> > >   obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
> > >   obj-$(CONFIG_OF_FPGA_REGION)		+= of-fpga-region.o
> > >   obj-$(CONFIG_FPGA_DFL) += dfl/
> > > +obj-$(CONFIG_FPGA_XILINX) += xilinx/
> > > diff --git a/drivers/fpga/xilinx/Kconfig b/drivers/fpga/xilinx/Kconfig
> > > new file mode 100644
> > > index 0000000000000..e016d450539a0
> > > --- /dev/null
> > > +++ b/drivers/fpga/xilinx/Kconfig
> > > @@ -0,0 +1,55 @@
> > > +# SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +config FPGA_XILINX
> > > +	bool "Xilinx FPGAs"
> > "Xilinx FPGA drivers"
> > 
> > > +	default y
> > > +	help
> > > +	  If you have a xilinx fpga, say Y.
> > "Xilix FPGA"
> Ok.
> > But how about being a bit more descriptive here:
> > 
> > "Select this option if you want to enable support for Xilinx FPGA
> > drivers"
> ok
> > 
> > > +	  Note that the answer to this question doesn't directly affect the
> > > +	  kernel: saying N will just cause the configurator to skip all
> > > +	  the questions about xilinx fpgas. If you say Y, you will be asked
> > > +	  for your specific device in the following questions.
> > Why this "note"?  Do networking drivers have this type of description?
> 
> Yes, the NET_VENDOR_* configs all have this boilerplate.

The first example I found drivers/net/ethernet/cavium/Kconfig, did not.
But you are right, others do.

But fix the case issues in this text please.  Vendors get mad enough
when we use their names, we should at least get the case correct when
using them.

thanks,

greg k-h
