Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A066D36DE63
	for <lists+linux-fpga@lfdr.de>; Wed, 28 Apr 2021 19:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbhD1Rhg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 28 Apr 2021 13:37:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240224AbhD1Rh3 (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 28 Apr 2021 13:37:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619631402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HK7++I1nhxfDG0XsoHKwoAOEamcD6GInXSZD7ed2Qzw=;
        b=Qo/F7MXsZc/9tcP0pzppW4tm3JkRTIkcQ6Btm6PORi4kYIep0VgJdK53UEGMWAF+C86rWc
        d2o8qUGCsIOZ5gnQ/jR+DlxCdvBFMHT6xTP7o+ep7WO39wRMaQqHzN+267x1MnSNcv85BF
        yvDsyrW+0wagTpJcISngPNZ2NXfk7+M=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-tul0KS9bOq-r8Kz32rxQfg-1; Wed, 28 Apr 2021 13:36:40 -0400
X-MC-Unique: tul0KS9bOq-r8Kz32rxQfg-1
Received: by mail-qv1-f72.google.com with SMTP id o7-20020a0cf4c70000b02901a53a28706fso23488551qvm.19
        for <linux-fpga@vger.kernel.org>; Wed, 28 Apr 2021 10:36:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=HK7++I1nhxfDG0XsoHKwoAOEamcD6GInXSZD7ed2Qzw=;
        b=Xyw5rS6gKlresIY28uARIengMwFZPzfGJREV/ku8Vw8IUQ/50iZtq1Q7kx3ZK8bHSU
         gX44/st7MUt/d9XPLQ8PXcvjluUngoQzF06b3PkG6eMdNuCuWLX0EneWdTEzp/AVk7kN
         LM2JeG23v16L6yC4SADKeoYN8aiTcijF+/TTxdxRRlASbu85HfV7Ors5N64ce4iADFT2
         R98e9XXQKdhnhtQW2Ue+f512Sq/aw+BOr70dkWWXjmXKobkBdf2/E1/N7Pgz+vCbg1bR
         R2rZa5JSLkHVvkBstxUDFEP5htdMi47cOY/v8aRigo7RBooWVwgYppO8BaQ4tDlpfTUz
         KDwg==
X-Gm-Message-State: AOAM533FKFiL+wTViIqAprf2xyHoXOzUasluchx9heYe2ykj3ZJVyEwA
        hjUQaMcLgFMp54lDl6PDKjr1siiCE/HrvMfcfCYNiIPCxgKWy6TVLcPY7X5Vb0Jrp6/gwsgegYN
        EVaNmTG6gtWQAJSjlyr5njg==
X-Received: by 2002:ac8:51d3:: with SMTP id d19mr27034157qtn.358.1619631399508;
        Wed, 28 Apr 2021 10:36:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzsTj0GTAReH+cHND+E0jX8G5x1A7SGplkei2ilbtVRFxxXyyqa5MMp3q7gkqfVnwG4QdGX5g==
X-Received: by 2002:ac8:51d3:: with SMTP id d19mr27034137qtn.358.1619631399214;
        Wed, 28 Apr 2021 10:36:39 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s25sm282019qkj.34.2021.04.28.10.36.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Apr 2021 10:36:38 -0700 (PDT)
Subject: Re: [PATCH V5 XRT Alveo 00/20] XRT Alveo driver overview
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <e80ecdca-1033-7619-1436-14603d785a71@redhat.com>
Date:   Wed, 28 Apr 2021 10:36:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 4/27/21 1:54 PM, Lizhi Hou wrote:
> Hello,
>
> This is V5 of patch series which adds management physical function driver
> for Xilinx Alveo PCIe accelerator cards.
>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>
> This driver is part of Xilinx Runtime (XRT) open source stack.
>
> XILINX ALVEO PLATFORM ARCHITECTURE
>
> Alveo PCIe FPGA based platforms have a static *shell* partition and a
> partial re-configurable *user* partition. The shell partition is
> automatically loaded from flash when host is booted and PCIe is enumerated
> by BIOS. Shell cannot be changed till the next cold reboot. The shell
> exposes two PCIe physical functions:
>
> 1. management physical function
> 2. user physical function
>
> The patch series includes Documentation/xrt.rst which describes Alveo
> platform, XRT driver architecture and deployment model in more detail.
>
> Users compile their high level design in C/C++/OpenCL or RTL into FPGA
> image using Vitis tools.
>      https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
>
> The compiled image is packaged as xclbin which contains partial bitstream
> for the user partition and necessary metadata. Users can dynamically swap
> the image running on the user partition in order to switch between
> different workloads by loading different xclbins.
>
> XRT DRIVERS FOR XILINX ALVEO
>
> XRT Linux kernel driver *xrt-mgnt* binds to management physical function of
> Alveo platform. The modular driver framework is organized into several
> platform drivers which primarily handle the following functionality:
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
> is documented in Documentation/xrt.rst.
>
> TESTING AND VALIDATION
>
> xrt-mgnt driver can be tested with full XRT open source stack which
> includes user space libraries, board utilities and (out of tree) first
> generation user physical function driver xocl. XRT open source runtime
> stack is available at https://github.com/Xilinx/XRT
>
> Complete documentation for XRT open source stack including sections on
> Alveo/XRT security and platform architecture can be found here:
>
> https://xilinx.github.io/XRT/master/html/index.html
> https://xilinx.github.io/XRT/master/html/security.html
> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>
> Changes since v4:
> - Added xrt_bus_type and xrt_device. All sub devices were changed from
>    platform_bus_type/platform_device to xrt_bus_type/xrt_device.
> - Renamed xrt-mgmt driver to xrt-mgnt driver.
> - Replaced 'MGMT' with 'MGNT' and 'mgmt' with 'mgnt' in code and file names
> - Moved pci function calls from infrastructure to xrt-mgnt driver.
> - Renamed files: mgmt/main.c -> mgnt/xmgnt-main.c
>                   mgmt/main-region.c -> mgnt/xmgnt-main-region.c
>                   include/xmgmt-main.h -> include/xmgnt-main.h
>                   mgmt/fmgr-drv.c -> mgnt/xrt-mgr.c
>                   mgmt/fmgr.h -> mgnt/xrt-mgr.h
> - Updated code base to include v4 code review comments.


An early run through with checkpatch complains about MAINTAINERS not 
being modified for new content.

This likely could be resolved by moving your MAINTAINERS change from 
patch 20 to patch 1.

And of course fixes to make the test robot happy :)


Thanks for the refactor to the xrt_bus!

I will start taking a look.

Tom


>
> Changes since v3:
> - Leaf drivers use regmap-mmio to access hardware registers.
> - Renamed driver module: xmgmt.ko -> xrt-mgmt.ko
> - Renamed files: calib.[c|h] -> ddr_calibration.[c|h],
>                   lib/main.[c|h] -> lib/lib-drv.[c|h],
>                   mgmt/main-impl.h - > mgmt/xmgnt.h
> - Updated code base to include v3 code review comments.
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
>    programming
> - Dropped platform drivers not related to PR programming to focus on XRT
>    core framework
> - Updated Documentation/fpga/xrt.rst with information on XRT core framework
> - Addressed checkpatch issues
> - Dropped xrt- prefix from some header files
>
> For reference V4 version of patch series can be found here:
>
> https://lore.kernel.org/lkml/20210324052947.27889-1-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-2-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-3-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-4-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-5-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-6-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-7-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-8-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-9-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-10-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-11-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-12-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-13-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-14-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-15-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-16-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-17-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-18-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-19-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-20-lizhi.hou@xilinx.com
> https://lore.kernel.org/lkml/20210324052947.27889-21-lizhi.hou@xilinx.com/
>
> Lizhi Hou (20):
>    Documentation: fpga: Add a document describing XRT Alveo drivers
>    fpga: xrt: driver metadata helper functions
>    fpga: xrt: xclbin file helper functions
>    fpga: xrt: xrt-lib driver manager
>    fpga: xrt: group driver
>    fpga: xrt: char dev node helper functions
>    fpga: xrt: root driver infrastructure
>    fpga: xrt: driver infrastructure
>    fpga: xrt: management physical function driver (root)
>    fpga: xrt: main driver for management function device
>    fpga: xrt: fpga-mgr and region implementation for xclbin download
>    fpga: xrt: VSEC driver
>    fpga: xrt: User Clock Subsystem driver
>    fpga: xrt: ICAP driver
>    fpga: xrt: devctl xrt driver
>    fpga: xrt: clock driver
>    fpga: xrt: clock frequency counter driver
>    fpga: xrt: DDR calibration driver
>    fpga: xrt: partition isolation driver
>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>
>   Documentation/fpga/index.rst                  |   1 +
>   Documentation/fpga/xrt.rst                    | 844 +++++++++++++++++
>   MAINTAINERS                                   |  11 +
>   drivers/Makefile                              |   1 +
>   drivers/fpga/Kconfig                          |   2 +
>   drivers/fpga/Makefile                         |   5 +
>   drivers/fpga/xrt/Kconfig                      |   8 +
>   drivers/fpga/xrt/include/events.h             |  45 +
>   drivers/fpga/xrt/include/group.h              |  25 +
>   drivers/fpga/xrt/include/metadata.h           | 236 +++++
>   drivers/fpga/xrt/include/subdev_id.h          |  38 +
>   drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
>   drivers/fpga/xrt/include/xdevice.h            | 131 +++
>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++
>   drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
>   drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
>   drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
>   drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
>   drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
>   drivers/fpga/xrt/include/xmgnt-main.h         |  34 +
>   drivers/fpga/xrt/include/xroot.h              | 117 +++
>   drivers/fpga/xrt/lib/Kconfig                  |  17 +
>   drivers/fpga/xrt/lib/Makefile                 |  30 +
>   drivers/fpga/xrt/lib/cdev.c                   | 210 +++++
>   drivers/fpga/xrt/lib/group.c                  | 278 ++++++
>   drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
>   drivers/fpga/xrt/lib/lib-drv.h                |  15 +
>   drivers/fpga/xrt/lib/subdev.c                 | 847 ++++++++++++++++++
>   drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
>   drivers/fpga/xrt/lib/xclbin.c                 | 369 ++++++++
>   drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
>   drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
>   drivers/fpga/xrt/lib/xleaf/clock.c            | 652 ++++++++++++++
>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
>   drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
>   drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
>   drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 ++++
>   drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
>   drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
>   drivers/fpga/xrt/metadata/Kconfig             |  12 +
>   drivers/fpga/xrt/metadata/Makefile            |  16 +
>   drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
>   drivers/fpga/xrt/mgnt/Kconfig                 |  15 +
>   drivers/fpga/xrt/mgnt/Makefile                |  19 +
>   drivers/fpga/xrt/mgnt/root.c                  | 419 +++++++++
>   drivers/fpga/xrt/mgnt/xmgnt-main-region.c     | 485 ++++++++++
>   drivers/fpga/xrt/mgnt/xmgnt-main.c            | 660 ++++++++++++++
>   drivers/fpga/xrt/mgnt/xmgnt.h                 |  33 +
>   drivers/fpga/xrt/mgnt/xrt-mgr.c               | 190 ++++
>   drivers/fpga/xrt/mgnt/xrt-mgr.h               |  16 +
>   include/uapi/linux/xrt/xclbin.h               | 409 +++++++++
>   include/uapi/linux/xrt/xmgnt-ioctl.h          |  46 +
>   53 files changed, 9931 insertions(+)
>   create mode 100644 Documentation/fpga/xrt.rst
>   create mode 100644 drivers/fpga/xrt/Kconfig
>   create mode 100644 drivers/fpga/xrt/include/events.h
>   create mode 100644 drivers/fpga/xrt/include/group.h
>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>   create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>   create mode 100644 drivers/fpga/xrt/include/xdevice.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>   create mode 100644 drivers/fpga/xrt/include/xmgnt-main.h
>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>   create mode 100644 drivers/fpga/xrt/lib/group.c
>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>   create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>   create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>   create mode 100644 drivers/fpga/xrt/mgnt/Kconfig
>   create mode 100644 drivers/fpga/xrt/mgnt/Makefile
>   create mode 100644 drivers/fpga/xrt/mgnt/root.c
>   create mode 100644 drivers/fpga/xrt/mgnt/xmgnt-main-region.c
>   create mode 100644 drivers/fpga/xrt/mgnt/xmgnt-main.c
>   create mode 100644 drivers/fpga/xrt/mgnt/xmgnt.h
>   create mode 100644 drivers/fpga/xrt/mgnt/xrt-mgr.c
>   create mode 100644 drivers/fpga/xrt/mgnt/xrt-mgr.h
>   create mode 100644 include/uapi/linux/xrt/xclbin.h
>   create mode 100644 include/uapi/linux/xrt/xmgnt-ioctl.h
>

