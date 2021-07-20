Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9C973D0205
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 21:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhGTSVD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 20 Jul 2021 14:21:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232555AbhGTSVB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 20 Jul 2021 14:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626807699;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g70XznyWL3/8IpWTs6YMFJpUsfafOYvoKkyv49UkBU0=;
        b=bu4NNYACOQAUW0Hs3SCo5qRfcB1KW2tfvlueAl+B4gut5LUfTbAUH9jEAZGQKtaYxMycc7
        D+aH8SV0AU2Dw36q3T5djIlFJFmE3ECTizBotIQraB8oYR+LGeAalJBD5EQ07blLRoURbV
        aTv5QqAwXQw++tIyshOag11ZLVvGn7Y=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-540-5MAf7rbGMm-ntgUyEoo8cA-1; Tue, 20 Jul 2021 15:01:37 -0400
X-MC-Unique: 5MAf7rbGMm-ntgUyEoo8cA-1
Received: by mail-ot1-f72.google.com with SMTP id a24-20020a9d6e980000b02904b7c1fa2d7cso18295509otr.16
        for <linux-fpga@vger.kernel.org>; Tue, 20 Jul 2021 12:01:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=g70XznyWL3/8IpWTs6YMFJpUsfafOYvoKkyv49UkBU0=;
        b=C0L9d3dk3sYvOgIH0m9DeU2ADc/W90sT/LZ7rZedxgBzTw8s86XVuQ0qv6z4ng/W8a
         pzuyzcaAnyuGWfiC9KnS7SfOK/5NwG2FCZIcG86N4wqBupMweoU0EQYOhmdTdv6aVsT/
         fanaoswrmo8rHCtKEpdo3w2uYONKTXbAu7C6QDoa3I0U49sJ/BUsKEpxbftlUbA1Cbmr
         elDF/reL0Mq/VchnwqOd9D0qUiiYwBD8auh2BsiI0k7JlrzgY4GEfU/Dew3voax4dPlS
         OwpdzD3Vh91/IHYsrxaApEfeaZcvUOlgQCLUmUYpEsQi7F1JW4seyprS72EMRkHU6kH/
         uviw==
X-Gm-Message-State: AOAM531R7BF7KWnxor5+slth0uMieKDZ4MgAzrgrd7SbvF5raDJtUQvZ
        MOPLqqnFfg9ANqyxmGk1LPCjiTzHBHXjKTwEc3xLwwhlwV3ySUzzgPa1vUhhONbxgdyd4UZk6yC
        3LFL57QLPgPv4N+WPlVQodQ==
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr23838225otq.353.1626807696935;
        Tue, 20 Jul 2021 12:01:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzFkwa/MJfG37p+7Gk3pkMlyh2VkNO5LMeIrl0q6AVA9Vfq1fM8doTWZdgpToqCadX9o8snYg==
X-Received: by 2002:a05:6830:1305:: with SMTP id p5mr23838206otq.353.1626807696698;
        Tue, 20 Jul 2021 12:01:36 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id p186sm1573390oif.49.2021.07.20.12.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 12:01:36 -0700 (PDT)
Subject: Re: [PATCH V8 XRT Alveo 00/14] XRT Alveo driver overview
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        "mdf@kernel.org" <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <73448caa-3282-b12f-c11b-4d41bf654f72@redhat.com>
Date:   Tue, 20 Jul 2021 12:01:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210719212628.134129-1-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 7/19/21 2:26 PM, Lizhi Hou wrote:
> Hello,
>
> This is V8 of patch series which adds management physical function driver
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
> XRT Linux kernel driver *xrt-mgmt* binds to management physical function of
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
> xrt-mgmt driver can be tested with full XRT open source stack which
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
> Changes since v7:
> - Followed review comment to remove non fpga subdevices:
>     clock, clkfrq, ucs, ddr_calibaration, devctl and vsec
> - Collapsed include/uapi/linux/xrt/*.h into include/uapi/linux/fpga-xrt.h
> - Cleaned up comments in fpga-xrt.h
> - Fixed spelling errors in xrt.rst

Lizhi,

Thanks, the changes look good.

Moritz,

I have no outstanding issues and I do not believe there are any from 
anyone else.

Can this set be included in fpga-next ?

Tom

>
> Changes since v6:
> - Resolved grammatical errors and cleaned up taxonomy in xrt.rst
>    documentation.
> - Fixed clang warnings.
> - Updated code base to include v6 code review comments.
>
> Changes since v5:
> - Revert all changes 'mgnt/MGNT' back to 'mgmt/MGMT'
> - Updated code base to include v5 code review comments.
>     xrt.rst: address grammar and taxonomy
>     subdev_id.h: defines XRT_SUBDEV_INVALID = 0
>     xclbin.c: change shift operation to be_to_cpu
> - Resolved kernel test robot errors.
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
> For reference V7 version of patch series can be found here:
> https://lore.kernel.org/lkml/20210528004959.61354-1-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-2-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-3-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-4-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-5-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-6-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-7-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-8-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-9-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-10-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-11-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-12-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-13-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-14-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-15-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-16-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-17-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-18-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-19-lizhi.hou@xilinx.com/
> https://lore.kernel.org/lkml/20210528004959.61354-20-lizhi.hou@xilinx.com/
>
> Lizhi Hou (14):
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
>    fpga: xrt: ICAP driver
>    fpga: xrt: partition isolation driver
>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>
>   Documentation/fpga/index.rst                  |   1 +
>   Documentation/fpga/xrt.rst                    | 870 ++++++++++++++++++
>   MAINTAINERS                                   |  11 +
>   drivers/Makefile                              |   1 +
>   drivers/fpga/Kconfig                          |   2 +
>   drivers/fpga/Makefile                         |   5 +
>   drivers/fpga/xrt/Kconfig                      |   8 +
>   drivers/fpga/xrt/include/events.h             |  45 +
>   drivers/fpga/xrt/include/group.h              |  25 +
>   drivers/fpga/xrt/include/metadata.h           | 236 +++++
>   drivers/fpga/xrt/include/subdev_id.h          |  39 +
>   drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
>   drivers/fpga/xrt/include/xdevice.h            | 131 +++
>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++
>   drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
>   drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
>   drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
>   drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
>   drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
>   drivers/fpga/xrt/include/xmgmt-main.h         |  34 +
>   drivers/fpga/xrt/include/xroot.h              | 117 +++
>   drivers/fpga/xrt/lib/Kconfig                  |  17 +
>   drivers/fpga/xrt/lib/Makefile                 |  24 +
>   drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
>   drivers/fpga/xrt/lib/group.c                  | 278 ++++++
>   drivers/fpga/xrt/lib/lib-drv.c                | 322 +++++++
>   drivers/fpga/xrt/lib/lib-drv.h                |  21 +
>   drivers/fpga/xrt/lib/subdev.c                 | 859 +++++++++++++++++
>   drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
>   drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
>   drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
>   drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
>   drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
>   drivers/fpga/xrt/metadata/Kconfig             |  12 +
>   drivers/fpga/xrt/metadata/Makefile            |  16 +
>   drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
>   drivers/fpga/xrt/mgmt/Kconfig                 |  15 +
>   drivers/fpga/xrt/mgmt/Makefile                |  19 +
>   drivers/fpga/xrt/mgmt/root.c                  | 420 +++++++++
>   drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
>   drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 +++++++++++++
>   drivers/fpga/xrt/mgmt/xmgmt.h                 |  33 +
>   drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
>   drivers/fpga/xrt/mgmt/xrt-mgr.h               |  16 +
>   include/uapi/linux/fpga-xrt.h                 | 428 +++++++++
>   46 files changed, 8171 insertions(+)
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
>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
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
>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h
>   create mode 100644 include/uapi/linux/fpga-xrt.h
>

