Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2B739A305
	for <lists+linux-fpga@lfdr.de>; Thu,  3 Jun 2021 16:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbhFCOZE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 3 Jun 2021 10:25:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36701 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231621AbhFCOZB (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Thu, 3 Jun 2021 10:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622730196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w5bPGjiUA0ORxtoWUHBqSULchX5OLwYgOoNcxSrOB+A=;
        b=e9WoCZiVxHRR1Sr1VOkK9UDAIVboY78P4AuWXWrPCx8J+5yQ5sdtRLXgEUL0L97D81st1n
        v5sBbHzrNd7sFrEwu8EqzEKu/3vYBypiVTPPgZuLwRHTyazZfv/t4JhB4QdZafcls6XSvb
        XiRiN9STMhnjTbIsDRBxA2bihW/LqQY=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-MrIQlnxGNeayxGht34OIjA-1; Thu, 03 Jun 2021 10:23:14 -0400
X-MC-Unique: MrIQlnxGNeayxGht34OIjA-1
Received: by mail-ot1-f72.google.com with SMTP id a22-20020a0568301016b02902a60679231fso3307473otp.6
        for <linux-fpga@vger.kernel.org>; Thu, 03 Jun 2021 07:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=w5bPGjiUA0ORxtoWUHBqSULchX5OLwYgOoNcxSrOB+A=;
        b=dDSyzc/O4f33SsjTmKiYlp3x2RkbAml6h0EtrVFl+yHQS1vQHQtCcZ+xDN+ytoLreq
         Gu64QlBU098zhyHEuB31E193BfsqafOM12SyzBbvnYFNwZQ2D12pCFt+kRNDVVh621U6
         E6RhljP7Apu9lY5HRQp176ttnvexs+DOYQQQDb6FrQIVrxL0PQFbDWmWozRab6dq25Rt
         GzjtM9ZaULlKLV52dF0F45m876i47kAgGNVJx392cfyIW3kHbkI5EG5BuqxYDsffVCIG
         QpZB7xirrc9V/nwerl6qt8aPV3wB1O/ST57glMhDkfWU69EVoZDbuP4K4HpYwmBFsI4w
         5DtQ==
X-Gm-Message-State: AOAM532iK0oJsY+7Rv8ocJnU2ejQI04mMwwRVyrWCltFTDIm2hi5uUqj
        IcpN3xM5Pf2GQuB8gz3E0dJiMp0cBnTbYuMEAX5V4AiHg1OHLpzQEVc/F5yKJaY9LuFOqYHWgOY
        60MIFsBiBkVtIA2hXQ4OV9A==
X-Received: by 2002:a05:6830:1e8b:: with SMTP id n11mr30645223otr.327.1622730193857;
        Thu, 03 Jun 2021 07:23:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGCzGHfTBLmBkX50SLBobQ0vyfStKGul0ELz3CqRDkIGacvZ+4I2Ge2HerGE2GJd/XtbwxGQ==
X-Received: by 2002:a05:6830:1e8b:: with SMTP id n11mr30645206otr.327.1622730193572;
        Thu, 03 Jun 2021 07:23:13 -0700 (PDT)
Received: from localhost.localdomain (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w11sm654773oov.19.2021.06.03.07.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 07:23:13 -0700 (PDT)
Subject: RFC : [PATCH V7 XRT Alveo 00/20] XRT Alveo driver overview
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org,
        "Wu, Hao" <hao.wu@intel.com>, "mdf@kernel.org" <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
 <bdd31ecc-f6c5-392b-1609-f05efcba7f88@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <68e85a4f-4a10-1ff9-0443-aa565878c855@redhat.com>
Date:   Thu, 3 Jun 2021 07:23:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <bdd31ecc-f6c5-392b-1609-f05efcba7f88@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 6/2/21 3:34 PM, Lizhi Hou wrote:
> Hi Moritz and Tom,
>
> Thanks a lot for reviewing the XRT patches. This v7 patches contains 
> our latest fixes for all review comments. And it seems auto build 
> robot is happy with it as well. Do you have more comment against v7? 
> What will be the next step for XRT patches if it looks ok to you?

Please do not add any features to the patchset.

When you add a feature, that tends to reset the review process.


For little stuff.

I need to look at the documentation again, iirc that was the only issue 
in v6.


For big stuff.

At the beginning some possible refactor questions were raised, I don't 
know if they have been resolved.

ex/

some of the leaf drivers like clock should be moved the clock subsystem

the xrt/ dir vs existing flat, we don't want both.

is your xrt bus consistent with dfl bus, can it support adding devices 
outside of fpga/xrt

how clean are the public headers


Since flipflopping on refactoring is a painful, let's try to get a 
consensus before moving forward.

This may mean the patchset is committed by parts as it and the existing 
code changes.


Lets start with the directory structure.

Since there are a lot of files in xrt, the xrt/ makes sense.

For other fpga's with a lot of files, say > 3, we need to change ex/

dfl-foo.c to dfl/foo.c

to be consistent.


The Kconfig and Makefiles for xrt/ and dfl/ would only be in that top 
subdir.

Which i think is a change for xrt/


I'll whip up something for dfl/ to move things along.

Tom


>
> Thanks,
>
> Lizhi
>
>
> On 05/27/2021 05:49 PM, Lizhi Hou wrote:
>> Hello,
>>
>> This is V7 of patch series which adds management physical function 
>> driver
>> for Xilinx Alveo PCIe accelerator cards.
>>      https://www.xilinx.com/products/boards-and-kits/alveo.html
>>
>> This driver is part of Xilinx Runtime (XRT) open source stack.
>>
>> XILINX ALVEO PLATFORM ARCHITECTURE
>>
>> Alveo PCIe FPGA based platforms have a static *shell* partition and a
>> partial re-configurable *user* partition. The shell partition is
>> automatically loaded from flash when host is booted and PCIe is 
>> enumerated
>> by BIOS. Shell cannot be changed till the next cold reboot. The shell
>> exposes two PCIe physical functions:
>>
>> 1. management physical function
>> 2. user physical function
>>
>> The patch series includes Documentation/xrt.rst which describes Alveo
>> platform, XRT driver architecture and deployment model in more detail.
>>
>> Users compile their high level design in C/C++/OpenCL or RTL into FPGA
>> image using Vitis tools.
>> https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html
>>
>> The compiled image is packaged as xclbin which contains partial 
>> bitstream
>> for the user partition and necessary metadata. Users can dynamically 
>> swap
>> the image running on the user partition in order to switch between
>> different workloads by loading different xclbins.
>>
>> XRT DRIVERS FOR XILINX ALVEO
>>
>> XRT Linux kernel driver *xrt-mgmt* binds to management physical 
>> function of
>> Alveo platform. The modular driver framework is organized into several
>> platform drivers which primarily handle the following functionality:
>>
>> 1.  Loading firmware container also called xsabin at driver attach time
>> 2.  Loading of user compiled xclbin with FPGA Manager integration
>> 3.  Clock scaling of image running on user partition
>> 4.  In-band sensors: temp, voltage, power, etc.
>> 5.  Device reset and rescan
>>
>> The platform drivers are packaged into *xrt-lib* helper module with well
>> defined interfaces. The module provides a pseudo-bus implementation 
>> for the
>> platform drivers. More details on the driver model can be found in
>> Documentation/xrt.rst.
>>
>> User physical function driver is not included in this patch series.
>>
>> LIBFDT REQUIREMENT
>>
>> XRT driver infrastructure uses Device Tree as a metadata format to 
>> discover
>> HW subsystems in the Alveo PCIe device. The Device Tree schema used 
>> by XRT
>> is documented in Documentation/xrt.rst.
>>
>> TESTING AND VALIDATION
>>
>> xrt-mgmt driver can be tested with full XRT open source stack which
>> includes user space libraries, board utilities and (out of tree) first
>> generation user physical function driver xocl. XRT open source runtime
>> stack is available at https://github.com/Xilinx/XRT
>>
>> Complete documentation for XRT open source stack including sections on
>> Alveo/XRT security and platform architecture can be found here:
>>
>> https://xilinx.github.io/XRT/master/html/index.html
>> https://xilinx.github.io/XRT/master/html/security.html
>> https://xilinx.github.io/XRT/master/html/platforms_partitions.html
>>
>> Changes since v6:
>> - Resolved grammatical errors and cleaned up taxonomy in xrt.rst
>>    documentation.
>> - Fixed clang warnings.
>> - Updated code base to include v6 code review comments.
>>
>> Changes since v5:
>> - Revert all changes 'mgnt/MGNT' back to 'mgmt/MGMT'
>> - Updated code base to include v5 code review comments.
>>     xrt.rst: address grammar and taxonomy
>>     subdev_id.h: defines XRT_SUBDEV_INVALID = 0
>>     xclbin.c: change shift operation to be_to_cpu
>> - Resolved kernel test robot errors.
>>
>> Changes since v4:
>> - Added xrt_bus_type and xrt_device. All sub devices were changed from
>>    platform_bus_type/platform_device to xrt_bus_type/xrt_device.
>> - Renamed xrt-mgmt driver to xrt-mgnt driver.
>> - Replaced 'MGMT' with 'MGNT' and 'mgmt' with 'mgnt' in code and file 
>> names
>> - Moved pci function calls from infrastructure to xrt-mgnt driver.
>> - Renamed files: mgmt/main.c -> mgnt/xmgnt-main.c
>>                   mgmt/main-region.c -> mgnt/xmgnt-main-region.c
>>                   include/xmgmt-main.h -> include/xmgnt-main.h
>>                   mgmt/fmgr-drv.c -> mgnt/xrt-mgr.c
>>                   mgmt/fmgr.h -> mgnt/xrt-mgr.h
>> - Updated code base to include v4 code review comments.
>>
>> Changes since v3:
>> - Leaf drivers use regmap-mmio to access hardware registers.
>> - Renamed driver module: xmgmt.ko -> xrt-mgmt.ko
>> - Renamed files: calib.[c|h] -> ddr_calibration.[c|h],
>>                   lib/main.[c|h] -> lib/lib-drv.[c|h],
>>                   mgmt/main-impl.h - > mgmt/xmgnt.h
>> - Updated code base to include v3 code review comments.
>>
>> Changes since v2:
>> - Streamlined the driver framework into *xleaf*, *group* and *xroot*
>> - Updated documentation to show the driver model with examples
>> - Addressed kernel test robot errors
>> - Added a selftest for basic driver framework
>> - Documented device tree schema
>> - Removed need to export libfdt symbols
>>
>> Changes since v1:
>> - Updated the driver to use fpga_region and fpga_bridge for FPGA
>>    programming
>> - Dropped platform drivers not related to PR programming to focus on XRT
>>    core framework
>> - Updated Documentation/fpga/xrt.rst with information on XRT core 
>> framework
>> - Addressed checkpatch issues
>> - Dropped xrt- prefix from some header files
>>
>> For reference V6 version of patch series can be found here:
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-1-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-2-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-3-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-4-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-5-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-6-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-7-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-8-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-9-lizhi.hou@xilinx.com/
>> https://lore.kernel.org/lkml/20210512015339.5649-10-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-11-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-12-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-13-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-14-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-15-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-16-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-17-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-18-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-19-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-20-lizhi.hou@xilinx.com/ 
>>
>> https://lore.kernel.org/lkml/20210512015339.5649-21-lizhi.hou@xilinx.com/ 
>>
>>
>> Lizhi Hou (20):
>>    Documentation: fpga: Add a document describing XRT Alveo drivers
>>    fpga: xrt: driver metadata helper functions
>>    fpga: xrt: xclbin file helper functions
>>    fpga: xrt: xrt-lib driver manager
>>    fpga: xrt: group driver
>>    fpga: xrt: char dev node helper functions
>>    fpga: xrt: root driver infrastructure
>>    fpga: xrt: driver infrastructure
>>    fpga: xrt: management physical function driver (root)
>>    fpga: xrt: main driver for management function device
>>    fpga: xrt: fpga-mgr and region implementation for xclbin download
>>    fpga: xrt: VSEC driver
>>    fpga: xrt: User Clock Subsystem driver
>>    fpga: xrt: ICAP driver
>>    fpga: xrt: devctl xrt driver
>>    fpga: xrt: clock driver
>>    fpga: xrt: clock frequency counter driver
>>    fpga: xrt: DDR calibration driver
>>    fpga: xrt: partition isolation driver
>>    fpga: xrt: Kconfig and Makefile updates for XRT drivers
>>
>>   Documentation/fpga/index.rst                  |   1 +
>>   Documentation/fpga/xrt.rst                    | 870 ++++++++++++++++++
>>   MAINTAINERS                                   |  11 +
>>   drivers/Makefile                              |   1 +
>>   drivers/fpga/Kconfig                          |   2 +
>>   drivers/fpga/Makefile                         |   5 +
>>   drivers/fpga/xrt/Kconfig                      |   8 +
>>   drivers/fpga/xrt/include/events.h             |  45 +
>>   drivers/fpga/xrt/include/group.h              |  25 +
>>   drivers/fpga/xrt/include/metadata.h           | 236 +++++
>>   drivers/fpga/xrt/include/subdev_id.h          |  39 +
>>   drivers/fpga/xrt/include/xclbin-helper.h      |  48 +
>>   drivers/fpga/xrt/include/xdevice.h            | 131 +++
>>   drivers/fpga/xrt/include/xleaf.h              | 205 +++++
>>   drivers/fpga/xrt/include/xleaf/axigate.h      |  23 +
>>   drivers/fpga/xrt/include/xleaf/clkfreq.h      |  21 +
>>   drivers/fpga/xrt/include/xleaf/clock.h        |  29 +
>>   .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +
>>   drivers/fpga/xrt/include/xleaf/devctl.h       |  40 +
>>   drivers/fpga/xrt/include/xleaf/icap.h         |  27 +
>>   drivers/fpga/xrt/include/xmgmt-main.h         |  34 +
>>   drivers/fpga/xrt/include/xroot.h              | 117 +++
>>   drivers/fpga/xrt/lib/Kconfig                  |  17 +
>>   drivers/fpga/xrt/lib/Makefile                 |  30 +
>>   drivers/fpga/xrt/lib/cdev.c                   | 209 +++++
>>   drivers/fpga/xrt/lib/group.c                  | 278 ++++++
>>   drivers/fpga/xrt/lib/lib-drv.c                | 328 +++++++
>>   drivers/fpga/xrt/lib/lib-drv.h                |  21 +
>>   drivers/fpga/xrt/lib/subdev.c                 | 859 +++++++++++++++++
>>   drivers/fpga/xrt/lib/subdev_pool.h            |  53 ++
>>   drivers/fpga/xrt/lib/xclbin.c                 | 381 ++++++++
>>   drivers/fpga/xrt/lib/xleaf/axigate.c          | 325 +++++++
>>   drivers/fpga/xrt/lib/xleaf/clkfreq.c          | 223 +++++
>>   drivers/fpga/xrt/lib/xleaf/clock.c            | 652 +++++++++++++
>>   drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 210 +++++
>>   drivers/fpga/xrt/lib/xleaf/devctl.c           | 169 ++++
>>   drivers/fpga/xrt/lib/xleaf/icap.c             | 328 +++++++
>>   drivers/fpga/xrt/lib/xleaf/ucs.c              | 152 +++
>>   drivers/fpga/xrt/lib/xleaf/vsec.c             | 372 ++++++++
>>   drivers/fpga/xrt/lib/xroot.c                  | 536 +++++++++++
>>   drivers/fpga/xrt/metadata/Kconfig             |  12 +
>>   drivers/fpga/xrt/metadata/Makefile            |  16 +
>>   drivers/fpga/xrt/metadata/metadata.c          | 578 ++++++++++++
>>   drivers/fpga/xrt/mgmt/Kconfig                 |  15 +
>>   drivers/fpga/xrt/mgmt/Makefile                |  19 +
>>   drivers/fpga/xrt/mgmt/root.c                  | 420 +++++++++
>>   drivers/fpga/xrt/mgmt/xmgmt-main-region.c     | 483 ++++++++++
>>   drivers/fpga/xrt/mgmt/xmgmt-main.c            | 662 +++++++++++++
>>   drivers/fpga/xrt/mgmt/xmgmt.h                 |  33 +
>>   drivers/fpga/xrt/mgmt/xrt-mgr.c               | 190 ++++
>>   drivers/fpga/xrt/mgmt/xrt-mgr.h               |  16 +
>>   include/uapi/linux/xrt/xclbin.h               | 409 ++++++++
>>   include/uapi/linux/xrt/xmgmt-ioctl.h          |  46 +
>>   53 files changed, 9988 insertions(+)
>>   create mode 100644 Documentation/fpga/xrt.rst
>>   create mode 100644 drivers/fpga/xrt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/include/events.h
>>   create mode 100644 drivers/fpga/xrt/include/group.h
>>   create mode 100644 drivers/fpga/xrt/include/metadata.h
>>   create mode 100644 drivers/fpga/xrt/include/subdev_id.h
>>   create mode 100644 drivers/fpga/xrt/include/xclbin-helper.h
>>   create mode 100644 drivers/fpga/xrt/include/xdevice.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/clock.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
>>   create mode 100644 drivers/fpga/xrt/include/xleaf/icap.h
>>   create mode 100644 drivers/fpga/xrt/include/xmgmt-main.h
>>   create mode 100644 drivers/fpga/xrt/include/xroot.h
>>   create mode 100644 drivers/fpga/xrt/lib/Kconfig
>>   create mode 100644 drivers/fpga/xrt/lib/Makefile
>>   create mode 100644 drivers/fpga/xrt/lib/cdev.c
>>   create mode 100644 drivers/fpga/xrt/lib/group.c
>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
>>   create mode 100644 drivers/fpga/xrt/lib/lib-drv.h
>>   create mode 100644 drivers/fpga/xrt/lib/subdev.c
>>   create mode 100644 drivers/fpga/xrt/lib/subdev_pool.h
>>   create mode 100644 drivers/fpga/xrt/lib/xclbin.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/clock.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/icap.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c
>>   create mode 100644 drivers/fpga/xrt/lib/xleaf/vsec.c
>>   create mode 100644 drivers/fpga/xrt/lib/xroot.c
>>   create mode 100644 drivers/fpga/xrt/metadata/Kconfig
>>   create mode 100644 drivers/fpga/xrt/metadata/Makefile
>>   create mode 100644 drivers/fpga/xrt/metadata/metadata.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
>>   create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>>   create mode 100644 drivers/fpga/xrt/mgmt/root.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main-region.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-main.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/xmgmt.h
>>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.c
>>   create mode 100644 drivers/fpga/xrt/mgmt/xrt-mgr.h
>>   create mode 100644 include/uapi/linux/xrt/xclbin.h
>>   create mode 100644 include/uapi/linux/xrt/xmgmt-ioctl.h
>>
>

