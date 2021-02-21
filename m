Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6B3E320DAA
	for <lists+linux-fpga@lfdr.de>; Sun, 21 Feb 2021 21:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbhBUUns (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 21 Feb 2021 15:43:48 -0500
Received: from mail-pj1-f44.google.com ([209.85.216.44]:51438 "EHLO
        mail-pj1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBUUnn (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 21 Feb 2021 15:43:43 -0500
Received: by mail-pj1-f44.google.com with SMTP id gm18so2129886pjb.1;
        Sun, 21 Feb 2021 12:43:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kKy1q8bkZx8uAoMiFkroQ1ykJR2Dczk8kC+VIA2JvWI=;
        b=VfDy+gDdZD9MGdRC126rkdHAdNxIhr+/jSueCnPg60YbDIV7l2Pry6uNwrfEg9nw27
         sXccsFCkj5kdCtTj2Yj6MDCvRU6dOIVm6XlF8dl6JeY94HP1ZRBhgQxoyPoD5nFKOVCC
         rFxUird/sKWLsYODJWnUVynY/dxLmGMDwbIsYIJX5dHHvUr2yQs7YI+3Bm/aeiY8csih
         Bz876Pl+ACOM4pa8fvPsFi7hvOO6VjimWokYYcUX6VumhX3aifz05OmIjzf1xGx3b1rs
         /r96/JVHqoGbaO3QqMhD+mZ+yEyekm+vxhTvoM+SMzIYL5VvOGmYFe1K7J4FsqPGNsxH
         tA+g==
X-Gm-Message-State: AOAM530BQAapxptYiKJ//niz1bzrPaWajJBh5gMpQBHKazoEt1voYpP8
        GC1BOQC62WyOfKFQ6f4V8Lo=
X-Google-Smtp-Source: ABdhPJzVsa1e44RGLgmcPHZVIHHV/7oGq8JU2/otMgK32f5yT4SzwCaYhDWIhHMk1K/JAD6+QlOekA==
X-Received: by 2002:a17:90b:4a8c:: with SMTP id lp12mr19687134pjb.214.1613940182342;
        Sun, 21 Feb 2021 12:43:02 -0800 (PST)
Received: from localhost ([2601:647:5b00:1162:1ac0:17a6:4cc6:d1ef])
        by smtp.gmail.com with ESMTPSA id lx1sm14786147pjb.8.2021.02.21.12.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Feb 2021 12:43:01 -0800 (PST)
Date:   Sun, 21 Feb 2021 12:43:04 -0800
From:   Moritz Fischer <mdf@kernel.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-kernel@vger.kernel.org, Lizhi Hou <lizhih@xilinx.com>,
        linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, trix@redhat.com,
        mdf@kernel.org, robh@kernel.org
Subject: Re: [PATCH V3 XRT Alveo 00/18] XRT Alveo driver overview
Message-ID: <YDLF2Bi3oEhP6A7Q@archbook>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Lizhi,

On Wed, Feb 17, 2021 at 10:40:01PM -0800, Lizhi Hou wrote:
> Hello,
> 
> This is V3 of patch series which adds management physical function driver for Xilinx
> Alveo PCIe accelerator cards, https://www.xilinx.com/products/boards-and-kits/alveo.html
> This driver is part of Xilinx Runtime (XRT) open source stack.
> 
> XILINX ALVEO PLATFORM ARCHITECTURE
> 
> Alveo PCIe FPGA based platforms have a static *shell* partition and a partial
> re-configurable *user* partition. The shell partition is automatically loaded from
> flash when host is booted and PCIe is enumerated by BIOS. Shell cannot be changed
> till the next cold reboot. The shell exposes two PCIe physical functions:
> 
> 1. management physical function
> 2. user physical function
> 
> The patch series includes Documentation/xrt.rst which describes Alveo platform,
> XRT driver architecture and deployment model in more detail.
> 
> Users compile their high level design in C/C++/OpenCL or RTL into FPGA image using
> Vitis https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
> tools. The compiled image is packaged as xclbin which contains partial bitstream
> for the user partition and necessary metadata. Users can dynamically swap the image
> running on the user partition in order to switch between different workloads by
> loading different xclbins.
> 
> XRT DRIVERS FOR XILINX ALVEO
> 
> XRT Linux kernel driver *xmgmt* binds to management physical function of Alveo
> platform. The modular driver framework is organized into several platform drivers
> which primarily handle the following functionality:
> 
> 1.  Loading firmware container also called xsabin at driver attach time
> 2.  Loading of user compiled xclbin with FPGA Manager integration
> 3.  Clock scaling of image running on user partition
> 4.  In-band sensors: temp, voltage, power, etc.
> 5.  Device reset and rescan
> 
> The platform drivers are packaged into *xrt-lib* helper module with well
> defined interfaces. The module provides a pseudo-bus implementation for the
> platform drivers. More details on the driver model can be found in
> Documentation/xrt.rst.
> 
> User physical function driver is not included in this patch series.
> 
> LIBFDT REQUIREMENT
> 
> XRT driver infrastructure uses Device Tree as a metadata format to discover
> HW subsystems in the Alveo PCIe device. The Device Tree schema used by XRT
> is documented in Documentation/xrt.rst. Unlike previous V1 and V2 version
> of patch series, V3 version does not require export of libfdt symbols.
> 
> TESTING AND VALIDATION
> 
> xmgmt driver can be tested with full XRT open source stack which includes user
> space libraries, board utilities and (out of tree) first generation user physical
> function driver xocl. XRT open source runtime stack is available at
> https://github.com/Xilinx/XRT
> 
> Complete documentation for XRT open source stack including sections on Alveo/XRT
> security and platform architecture can be found here:
> 
> https://xilinx.github.io/XRT/master/html/index.html
> https://xilinx.github.io/XRT/master/html/security.html
> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
> 
> Changes since v2:
> - Streamlined the driver framework into *xleaf*, *group* and *xroot*
> - Updated documentation to show the driver model with examples
> - Addressed kernel test robot errors
> - Added a selftest for basic driver framework
> - Documented device tree schema
> - Removed need to export libfdt symbols
> 
> Changes since v1:
> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>   programming
> - Dropped platform drivers not related to PR programming to focus on XRT
>   core framework
> - Updated Documentation/fpga/xrt.rst with information on XRT core framework
> - Addressed checkpatch issues
> - Dropped xrt- prefix from some header files
> 
> For reference V1 version of patch series can be found here:
> 
> https://lore.kernel.org/lkml/20201217075046.28553-1-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-2-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-3-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-4-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-5-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-6-sonals@xilinx.com/
> https://lore.kernel.org/lkml/20201217075046.28553-7-sonals@xilinx.com/
> 
> Lizhi Hou (18):
>   Documentation: fpga: Add a document describing XRT Alveo drivers
>   fpga: xrt: driver metadata helper functions
>   fpga: xrt: xclbin file helper functions
>   fpga: xrt: xrt-lib platform driver manager
>   fpga: xrt: group platform driver
>   fpga: xrt: platform driver infrastructure
>   fpga: xrt: management physical function driver (root)
>   fpga: xrt: main platform driver for management function device
>   fpga: xrt: fpga-mgr and region implementation for xclbin download
>   fpga: xrt: VSEC platform driver
>   fpga: xrt: UCS platform driver
>   fpga: xrt: ICAP platform driver
>   fpga: xrt: devctl platform driver
>   fpga: xrt: clock platform driver
>   fpga: xrt: clock frequence counter platform driver
>   fpga: xrt: DDR calibration platform driver
>   fpga: xrt: partition isolation platform driver
>   fpga: xrt: Kconfig and Makefile updates for XRT drivers
> 
>  Documentation/fpga/index.rst             |   1 +
>  Documentation/fpga/xrt.rst               | 842 ++++++++++++++++++++++
>  MAINTAINERS                              |  11 +
>  drivers/Makefile                         |   1 +
>  drivers/fpga/Kconfig                     |   2 +
>  drivers/fpga/Makefile                    |   4 +
>  drivers/fpga/xrt/Kconfig                 |   8 +
>  drivers/fpga/xrt/include/events.h        |  48 ++
>  drivers/fpga/xrt/include/group.h         |  27 +
>  drivers/fpga/xrt/include/metadata.h      | 229 ++++++
>  drivers/fpga/xrt/include/subdev_id.h     |  43 ++
>  drivers/fpga/xrt/include/xclbin-helper.h |  52 ++
>  drivers/fpga/xrt/include/xleaf.h         | 276 +++++++
>  drivers/fpga/xrt/include/xleaf/axigate.h |  25 +
>  drivers/fpga/xrt/include/xleaf/calib.h   |  30 +
>  drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +
>  drivers/fpga/xrt/include/xleaf/clock.h   |  31 +
>  drivers/fpga/xrt/include/xleaf/devctl.h  |  43 ++
>  drivers/fpga/xrt/include/xleaf/icap.h    |  29 +
>  drivers/fpga/xrt/include/xleaf/ucs.h     |  24 +
>  drivers/fpga/xrt/include/xmgmt-main.h    |  37 +
>  drivers/fpga/xrt/include/xroot.h         | 114 +++
>  drivers/fpga/xrt/lib/Kconfig             |  16 +
>  drivers/fpga/xrt/lib/Makefile            |  30 +
>  drivers/fpga/xrt/lib/cdev.c              | 231 ++++++
>  drivers/fpga/xrt/lib/group.c             | 265 +++++++
>  drivers/fpga/xrt/lib/main.c              | 274 +++++++
>  drivers/fpga/xrt/lib/main.h              |  17 +
>  drivers/fpga/xrt/lib/subdev.c            | 871 +++++++++++++++++++++++
>  drivers/fpga/xrt/lib/subdev_pool.h       |  53 ++
>  drivers/fpga/xrt/lib/xclbin.c            | 394 ++++++++++
>  drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 ++++++++
>  drivers/fpga/xrt/lib/xleaf/calib.c       | 226 ++++++
>  drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 ++++++
>  drivers/fpga/xrt/lib/xleaf/clock.c       | 648 +++++++++++++++++
>  drivers/fpga/xrt/lib/xleaf/devctl.c      | 206 ++++++
>  drivers/fpga/xrt/lib/xleaf/icap.c        | 317 +++++++++
>  drivers/fpga/xrt/lib/xleaf/ucs.c         | 235 ++++++
>  drivers/fpga/xrt/lib/xleaf/vsec.c        | 359 ++++++++++
>  drivers/fpga/xrt/lib/xroot.c             | 598 ++++++++++++++++
>  drivers/fpga/xrt/metadata/Kconfig        |  12 +
>  drivers/fpga/xrt/metadata/Makefile       |  16 +
>  drivers/fpga/xrt/metadata/metadata.c     | 524 ++++++++++++++
>  drivers/fpga/xrt/mgmt/Kconfig            |  15 +
>  drivers/fpga/xrt/mgmt/Makefile           |  19 +
>  drivers/fpga/xrt/mgmt/fmgr-drv.c         | 187 +++++
>  drivers/fpga/xrt/mgmt/fmgr.h             |  28 +
>  drivers/fpga/xrt/mgmt/main-impl.h        |  37 +
>  drivers/fpga/xrt/mgmt/main-region.c      | 471 ++++++++++++
>  drivers/fpga/xrt/mgmt/main.c             | 693 ++++++++++++++++++
>  drivers/fpga/xrt/mgmt/root.c             | 342 +++++++++
>  include/uapi/linux/xrt/xclbin.h          | 408 +++++++++++
>  include/uapi/linux/xrt/xmgmt-ioctl.h     |  46 ++
>  53 files changed, 9957 insertions(+)
>  create mode 100644 Documentation/fpga/xrt.rst
>  create mode 100644 drivers/fpga/xrt/Kconfig
>  create mode 100644 drivers/fpga/xrt/include/events.h
>  create mode 100644 drivers/fpga/xrt/include/group.h
>  create mode 100644 drivers/fpga/xrt/include/metadata.h
>  create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>  create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>  create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
>  create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>  create mode 100644 drivers/fpga/xrt/include/xroot.h
>  create mode 100644 drivers/fpga/xrt/lib/Kconfig
>  create mode 100644 drivers/fpga/xrt/lib/Makefile
>  create mode 100644 drivers/fpga/xrt/lib/cdev.c
>  create mode 100644 drivers/fpga/xrt/lib/group.c
>  create mode 100644 drivers/fpga/xrt/lib/main.c
>  create mode 100644 drivers/fpga/xrt/lib/main.h
>  create mode 100644 drivers/fpga/xrt/lib/subdev.c
>  create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>  create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>  create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>  create mode 100644 drivers/fpga/xrt/lib/xroot.c
>  create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>  create mode 100644 drivers/fpga/xrt/metadata/Makefile
>  create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>  create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>  create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>  create mode 100644 drivers/fpga/xrt/mgmt/fmgr-drv.c
>  create mode 100644 drivers/fpga/xrt/mgmt/fmgr.h
>  create mode 100644 drivers/fpga/xrt/mgmt/main-impl.h
>  create mode 100644 drivers/fpga/xrt/mgmt/main-region.c
>  create mode 100644 drivers/fpga/xrt/mgmt/main.c
>  create mode 100644 drivers/fpga/xrt/mgmt/root.c
>  create mode 100644 include/uapi/linux/xrt/xclbin.h
>  create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
> 
> -- 
> 2.18.4
> 

Please fix the indents all across this patchset. Doesn't checkpatch with
--strict complain about this?

Also more generally this looks like it should be a bus. Look at DFL for
reference.

- Moritz
