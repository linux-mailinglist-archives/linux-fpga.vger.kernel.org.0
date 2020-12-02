Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69CB02CB2C4
	for <lists+linux-fpga@lfdr.de>; Wed,  2 Dec 2020 03:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgLBCTx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 1 Dec 2020 21:19:53 -0500
Received: from mga11.intel.com ([192.55.52.93]:26084 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgLBCTw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 1 Dec 2020 21:19:52 -0500
IronPort-SDR: vJVXIyn6j8zHAzXjP5vmPRhHHsXCvVfDflgM6pQgCVfA+uwXWPzgi4qOVbkMCASLFgT66QLhyN
 ZVup3S5CelJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9822"; a="169439053"
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="169439053"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2020 18:19:03 -0800
IronPort-SDR: YyphVKIJMxkzErUFCD7jdUx/APpIZcgJOPNNETj0h6ONDs3iQ3Qp5CBzYMt0g1e704YkDkJdMh
 vPDe9b8MLktw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,385,1599548400"; 
   d="scan'208";a="481351701"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by orsmga004.jf.intel.com with ESMTP; 01 Dec 2020 18:18:58 -0800
Date:   Wed, 2 Dec 2020 10:14:29 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Sonal Santan <sonal.santan@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Sonal Santan <sonals@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com, lizhih@xilinx.com,
        michal.simek@xilinx.com, stefanos@xilinx.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH Xilinx Alveo 0/8] Xilinx Alveo/XRT patch overview
Message-ID: <20201202021429.GC22103@yilunxu-OptiPlex-7050>
References: <20201129000040.24777-1-sonals@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129000040.24777-1-sonals@xilinx.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

On Sat, Nov 28, 2020 at 04:00:32PM -0800, Sonal Santan wrote:
> Hello,
> 
> This patch series adds management physical function driver for Xilinx Alveo PCIe
> accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> This driver is part of Xilinx Runtime (XRT) open source stack.
> 
> The patch depends on the "PATCH Xilinx Alveo libfdt prep" which was posted
> before.
> 
> ALVEO PLATFORM ARCHITECTURE
> 
> Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
> re-configurable *user* partition. The shell partition is automatically loaded from
> flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> till the next cold reboot. The shell exposes two PCIe physical functions:
> 
> 1. management physical function
> 2. user physical function
> 
> The patch series includes Documentation/xrt.rst which describes Alveo
> platform, xmgmt driver architecture and deployment model in more more detail.
> 
> Users compile their high level design in C/C++/OpenCL or RTL into FPGA image
> using Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
> tools. The image is packaged as xclbin and contains partial bitstream for the
> user partition and necessary metadata. Users can dynamically swap the image
> running on the user partition in order to switch between different workloads.
> 
> ALVEO DRIVERS
> 
> Alveo Linux kernel driver *xmgmt* binds to management physical function of
> Alveo platform. The modular driver framework is organized into several
> platform drivers which primarily handle the following functionality:
> 
> 1.  Loading firmware container also called xsabin at driver attach time
> 2.  Loading of user compiled xclbin with FPGA Manager integration
> 3.  Clock scaling of image running on user partition
> 4.  In-band sensors: temp, voltage, power, etc.
> 5.  Device reset and rescan
> 6.  Flashing static *shell* partition
> 
> The platform drivers are packaged into *xrt-lib* helper module with a well
> defined interfaces the details of which can be found in Documentation/xrt.rst.
> 
> xmgmt driver is second generation Alveo management driver and evolution of
> the first generation (out of tree) Alveo management driver, xclmgmt. The
> sources of the first generation drivers were posted on LKML last year--
> https://lore.kernel.org/lkml/20190319215401.6562-1-sonal.santan@xilinx.com/
> 
> Changes since the first generation driver include the following: the driver
> has been re-architected as data driven modular driver; the driver has been
> split into xmgmt and xrt-lib; user physical function driver has been removed
> from the patch series.
> 
> Alveo/XRT security and platform architecture is documented on the following 
> GitHub pages:
> https://xilinx.github.io/XRT/master/html/security.html
> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
> 
> User physical function driver is not included in this patch series.
> 
> TESTING AND VALIDATION
> 
> xmgmt driver can be tested with full XRT open source stack which includes
> user space libraries, board utilities and (out of tree) first generation
> user physical function driver xocl. XRT open source runtime stack is
> available at https://github.com/Xilinx/XRT. This patch series has been
> validated on Alveo U50 platform.
> 
> Complete documentation for XRT open source stack can be found here--
> https://xilinx.github.io/XRT/master/html/index.html
> 
> Thanks,
> -Sonal
> 
> Sonal Santan (8):
>   Documentation: fpga: Add a document describing Alveo XRT drivers
>   fpga: xrt: Add UAPI header files
>   fpga: xrt: infrastructure support for xmgmt driver
>   fpga: xrt: core infrastructure for xrt-lib module
>   fpga: xrt: platform drivers for subsystems in shell partition

Seems the Patch #5 is missing in this seriies.

Thanks,
Yilun

>   fpga: xrt: header file for platform and parent drivers
>   fpga: xrt: Alveo management physical function driver
>   fpga: xrt: Kconfig and Makefile updates for XRT drivers
> 
>  Documentation/fpga/index.rst                  |    1 +
>  Documentation/fpga/xrt.rst                    |  588 +++++
>  drivers/fpga/Kconfig                          |    2 +
>  drivers/fpga/Makefile                         |    3 +
>  drivers/fpga/alveo/Kconfig                    |    7 +
>  drivers/fpga/alveo/common/xrt-metadata.c      |  590 +++++
>  drivers/fpga/alveo/common/xrt-root.c          |  744 +++++++
>  drivers/fpga/alveo/common/xrt-root.h          |   24 +
>  drivers/fpga/alveo/common/xrt-xclbin.c        |  387 ++++
>  drivers/fpga/alveo/common/xrt-xclbin.h        |   46 +
>  drivers/fpga/alveo/include/xmgmt-main.h       |   34 +
>  drivers/fpga/alveo/include/xrt-axigate.h      |   31 +
>  drivers/fpga/alveo/include/xrt-calib.h        |   28 +
>  drivers/fpga/alveo/include/xrt-clkfreq.h      |   21 +
>  drivers/fpga/alveo/include/xrt-clock.h        |   29 +
>  drivers/fpga/alveo/include/xrt-cmc.h          |   23 +
>  drivers/fpga/alveo/include/xrt-ddr-srsr.h     |   29 +
>  drivers/fpga/alveo/include/xrt-flash.h        |   28 +
>  drivers/fpga/alveo/include/xrt-gpio.h         |   41 +
>  drivers/fpga/alveo/include/xrt-icap.h         |   27 +
>  drivers/fpga/alveo/include/xrt-mailbox.h      |   44 +
>  drivers/fpga/alveo/include/xrt-metadata.h     |  184 ++
>  drivers/fpga/alveo/include/xrt-parent.h       |  103 +
>  drivers/fpga/alveo/include/xrt-partition.h    |   33 +
>  drivers/fpga/alveo/include/xrt-subdev.h       |  333 +++
>  drivers/fpga/alveo/include/xrt-ucs.h          |   22 +
>  drivers/fpga/alveo/lib/Kconfig                |   11 +
>  drivers/fpga/alveo/lib/Makefile               |   42 +
>  drivers/fpga/alveo/lib/subdevs/xrt-axigate.c  |  298 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-calib.c    |  291 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c  |  214 ++
>  drivers/fpga/alveo/lib/subdevs/xrt-clock.c    |  638 ++++++
>  .../fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c   |  343 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c |  322 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h |  135 ++
>  .../fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c  |  320 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c   |  361 ++++
>  .../fpga/alveo/lib/subdevs/xrt-cmc-sensors.c  |  445 ++++
>  drivers/fpga/alveo/lib/subdevs/xrt-cmc.c      |  239 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-gpio.c     |  198 ++
>  drivers/fpga/alveo/lib/subdevs/xrt-icap.c     |  306 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c  | 1905 +++++++++++++++++
>  .../fpga/alveo/lib/subdevs/xrt-partition.c    |  261 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-qspi.c     | 1347 ++++++++++++
>  drivers/fpga/alveo/lib/subdevs/xrt-srsr.c     |  322 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-test.c     |  274 +++
>  drivers/fpga/alveo/lib/subdevs/xrt-ucs.c      |  238 ++
>  .../fpga/alveo/lib/subdevs/xrt-vsec-golden.c  |  238 ++
>  drivers/fpga/alveo/lib/subdevs/xrt-vsec.c     |  337 +++
>  drivers/fpga/alveo/lib/xrt-cdev.c             |  234 ++
>  drivers/fpga/alveo/lib/xrt-main.c             |  275 +++
>  drivers/fpga/alveo/lib/xrt-main.h             |   46 +
>  drivers/fpga/alveo/lib/xrt-subdev.c           | 1007 +++++++++
>  drivers/fpga/alveo/mgmt/Kconfig               |   11 +
>  drivers/fpga/alveo/mgmt/Makefile              |   28 +
>  drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c      |  194 ++
>  drivers/fpga/alveo/mgmt/xmgmt-fmgr.h          |   29 +
>  drivers/fpga/alveo/mgmt/xmgmt-main-impl.h     |   36 +
>  drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c  |  930 ++++++++
>  drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c      |  190 ++
>  drivers/fpga/alveo/mgmt/xmgmt-main.c          |  843 ++++++++
>  drivers/fpga/alveo/mgmt/xmgmt-root.c          |  375 ++++
>  include/uapi/linux/xrt/flash_xrt_data.h       |   67 +
>  include/uapi/linux/xrt/mailbox_proto.h        |  394 ++++
>  include/uapi/linux/xrt/mailbox_transport.h    |   74 +
>  include/uapi/linux/xrt/xclbin.h               |  418 ++++
>  include/uapi/linux/xrt/xmgmt-ioctl.h          |   72 +
>  67 files changed, 17710 insertions(+)
>  create mode 100644 Documentation/fpga/xrt.rst
>  create mode 100644 drivers/fpga/alveo/Kconfig
>  create mode 100644 drivers/fpga/alveo/common/xrt-metadata.c
>  create mode 100644 drivers/fpga/alveo/common/xrt-root.c
>  create mode 100644 drivers/fpga/alveo/common/xrt-root.h
>  create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.c
>  create mode 100644 drivers/fpga/alveo/common/xrt-xclbin.h
>  create mode 100644 drivers/fpga/alveo/include/xmgmt-main.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-axigate.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-calib.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-clkfreq.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-clock.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-cmc.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-ddr-srsr.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-flash.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-gpio.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-icap.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-mailbox.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-metadata.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-parent.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-partition.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-subdev.h
>  create mode 100644 drivers/fpga/alveo/include/xrt-ucs.h
>  create mode 100644 drivers/fpga/alveo/lib/Kconfig
>  create mode 100644 drivers/fpga/alveo/lib/Makefile
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-axigate.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-calib.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clkfreq.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-clock.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-bdinfo.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-ctrl.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-impl.h
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-mailbox.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sc.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc-sensors.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-cmc.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-gpio.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-icap.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-mailbox.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-partition.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-qspi.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-srsr.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-test.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-ucs.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec-golden.c
>  create mode 100644 drivers/fpga/alveo/lib/subdevs/xrt-vsec.c
>  create mode 100644 drivers/fpga/alveo/lib/xrt-cdev.c
>  create mode 100644 drivers/fpga/alveo/lib/xrt-main.c
>  create mode 100644 drivers/fpga/alveo/lib/xrt-main.h
>  create mode 100644 drivers/fpga/alveo/lib/xrt-subdev.c
>  create mode 100644 drivers/fpga/alveo/mgmt/Kconfig
>  create mode 100644 drivers/fpga/alveo/mgmt/Makefile
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr-drv.c
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-fmgr.h
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-impl.h
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-mailbox.c
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main-ulp.c
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-main.c
>  create mode 100644 drivers/fpga/alveo/mgmt/xmgmt-root.c
>  create mode 100644 include/uapi/linux/xrt/flash_xrt_data.h
>  create mode 100644 include/uapi/linux/xrt/mailbox_proto.h
>  create mode 100644 include/uapi/linux/xrt/mailbox_transport.h
>  create mode 100644 include/uapi/linux/xrt/xclbin.h
>  create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
> 
> --
> 2.17.1
