Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E6632015C
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Feb 2021 23:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhBSW1m (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Feb 2021 17:27:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56653 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229774AbhBSW1l (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Feb 2021 17:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613773570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=booiSpwr312i4Xe7EpLAR4Y/+Mr5Af8dcnoiunOkOh4=;
        b=ZdKH9ouBMVbrsbDgz87EVD6mkpVX+iK7djB2sY1WYgjV6mjXi5PHId+9ZtBC0xGzP/r0Hp
        wgp2RK0EH08mJ/y08UVlNmUgb4kIhppWmZMRd3RA5maKlrBvb/Rr8DDUIn8V/CFUkzvlzu
        wm71NZMb/VIHL1kbQcec7I7ImbeMDPs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-CTIF55EgNkSQ3bAGTSl7KQ-1; Fri, 19 Feb 2021 17:26:08 -0500
X-MC-Unique: CTIF55EgNkSQ3bAGTSl7KQ-1
Received: by mail-qk1-f198.google.com with SMTP id b27so4516768qkl.11
        for <linux-fpga@vger.kernel.org>; Fri, 19 Feb 2021 14:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=booiSpwr312i4Xe7EpLAR4Y/+Mr5Af8dcnoiunOkOh4=;
        b=U1AiVJh84Z7zOyECCZg6U0iXmdeXe8kBw4nUfrJyyVmGt7HTFCMBQBlHYCChc7MjF1
         IZIHCyfSMees3dTZvQmgn9heMfcLX2qNnxtgCZz/lY+ro5H5H57uWbLT1VXDuymEruTK
         K4EtjfOc2rptJmvW59KFVAHFaINEIXp0QiRV0GtW2YWTedR/M+jTInkhtjusHrrwKMvJ
         I3tiIp0ZuuQNf6q7HKyh5I0GF5EjILYPIhozalSbmLzIw6Jb8R0kRzzfiMlwTm4cEFnw
         05ZuFSuTPl6LbTehF+MFqx/F3G8FlyfD40HPksXeO2+bFMqMpaLUkEIYYK/vSC55frgB
         TQEg==
X-Gm-Message-State: AOAM532ZEkqlmopzBhMYugZmG+djIg/rP7A8h3nIsYFsfEKYrn0eLchQ
        wS8iuZNuIrgTUGIv6spcmfruPtdasiJcveJPKCfxTGZ7QXqO1+UzmDoque/mSjsuc+eJ0yet4ZK
        Lzf28h9k31+o1u//NLufqAw==
X-Received: by 2002:ac8:58c5:: with SMTP id u5mr11106297qta.94.1613773566915;
        Fri, 19 Feb 2021 14:26:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQr0BSBKhofEo4sPMfEwNwSDANrnUdNzcfodgyXAK2amwE3pIm4x/YD9knkJUjNeApIhV8hA==
X-Received: by 2002:ac8:58c5:: with SMTP id u5mr11106260qta.94.1613773566319;
        Fri, 19 Feb 2021 14:26:06 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id 6sm7408876qkv.24.2021.02.19.14.26.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Feb 2021 14:26:05 -0800 (PST)
Subject: Re: [PATCH V3 XRT Alveo 01/18] Documentation: fpga: Add a document
 describing XRT Alveo drivers
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     Lizhi Hou <lizhih@xilinx.com>, linux-fpga@vger.kernel.org,
        maxz@xilinx.com, sonal.santan@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, Max Zhen <max.zhen@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
 <20210218064019.29189-2-lizhih@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3d3028aa-163f-7e5c-8730-1eb94ebf61c5@redhat.com>
Date:   Fri, 19 Feb 2021 14:26:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210218064019.29189-2-lizhih@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

From the documentation, there are a couple of big questions and a bunch of word smithing.

pseudo-bus : do we need a bus ?

xrt-lib real platform devices that aren't fpga, do they need to move to another subsystem ?

Overall looks good, love the ascii art!

On 2/17/21 10:40 PM, Lizhi Hou wrote:
> Describe XRT driver architecture and provide basic overview of
> Xilinx Alveo platform.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
> ---
>  Documentation/fpga/index.rst |   1 +
>  Documentation/fpga/xrt.rst   | 842 +++++++++++++++++++++++++++++++++++
>  2 files changed, 843 insertions(+)
>  create mode 100644 Documentation/fpga/xrt.rst
>
> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> index f80f95667ca2..30134357b70d 100644
> --- a/Documentation/fpga/index.rst
> +++ b/Documentation/fpga/index.rst
> @@ -8,6 +8,7 @@ fpga
>      :maxdepth: 1
>  
>      dfl
> +    xrt
>  
>  .. only::  subproject and html
>  
> diff --git a/Documentation/fpga/xrt.rst b/Documentation/fpga/xrt.rst
> new file mode 100644
> index 000000000000..9bc2d2785cb9
> --- /dev/null
> +++ b/Documentation/fpga/xrt.rst
> @@ -0,0 +1,842 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==================================
> +XRTV2 Linux Kernel Driver Overview
> +==================================
> +
> +Authors:
> +
> +* Sonal Santan <sonal.santan@xilinx.com>
> +* Max Zhen <max.zhen@xilinx.com>
> +* Lizhi Hou <lizhi.hou@xilinx.com>
> +
> +XRTV2 drivers are second generation `XRT <https://github.com/Xilinx/XRT>`_
> +drivers which support `Alveo <https://www.xilinx.com/products/boards-and-kits/alveo.html>`_
> +PCIe platforms from Xilinx.
> +
> +XRTV2 drivers support *subsystem* style data driven platforms where driver's
where the driver's
> +configuration and behavior is determined by meta data provided by the platform
> +(in *device tree* format). Primary management physical function (MPF) driver
> +is called **xmgmt**. Primary user physical function (UPF) driver is called
> +**xuser** and is under development. xrt driver framework and HW subsystem
> +drivers are packaged into a library module called **xrt-lib**, which is
> +shared by **xmgmt** and **xuser** (under development). The xrt driver framework
xuser still under development ?
> +implements a pseudo-bus which is used to discover HW subsystems and facilitate

A pseudo-bus.

It would be good if this was close to what was done for dfl here

https://lore.kernel.org/linux-fpga/1605159759-3439-1-git-send-email-yilun.xu@intel.com/

> +inter HW subsystem interaction.
> +
> +Driver Modules
> +==============
> +
> +xrt-lib.ko
> +----------
> +
> +Repository of all subsystem drivers and pure software modules that can potentially

subsystem drivers

drivers in fpga/ should be for managing just the fpganess of the fpga.

soft devices ex/ a soft tty should go to their respective subsystem location

Are there any in this patchset you think might move ?

Maybe we can defer reviewing those now.

> +be shared between xmgmt and xuser. All these drivers are structured as Linux
> +*platform driver* and are instantiated by xmgmt (or xuser under development) based
> +on meta data associated with hardware. The metadata is in the form of device tree

with the hardware

form of a device tree

> +as mentioned before. Each platform driver statically defines a subsystem node
> +array by using node name or a string in its ``compatible`` property. And this
> +array is eventually translated to IOMEM resources of the platform device.
> +
> +The xrt-lib core infrastructure provides hooks to platform drivers for device node
> +management, user file operations and ioctl callbacks. The core also provides pseudo-bus
> +functionality for platform driver registration, discovery and inter platform driver
> +ioctl calls.

core infrastructure.

The interfaces to the infrastructure are not in include/linux/fpga/

Maybe this needs to change.

> +
> +.. note::
> +   See code in ``include/xleaf.h``
> +
> +
> +xmgmt.ko
> +--------
> +
> +The xmgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
> +PCIE device. It consists of one *root* driver, one or more *group* drivers
> +and one or more *xleaf* drivers. The root and MPF specific xleaf drivers are
> +in xmgmt.ko. The group driver and other xleaf drivers are in xrt-lib.ko.
I am not sure if *.ko is correct, these will also be intree.
> +
> +The instantiation of specific group driver or xleaf driver is completely data
of a specific
> +driven based on meta data (mostly in device tree format) found through VSEC
mostly ? what is the deviation from device tree ?
> +capability and inside firmware files, such as platform xsabin or user xclbin file.
> +The root driver manages life cycle of multiple group drivers, which, in turn,
the life cycle
> +manages multiple xleaf drivers. This allows a single set of driver code to support

set of drivers

drop 'code'

> +all kinds of subsystems exposed by different shells. The difference among all
> +these subsystems will be handled in xleaf drivers with root and group drivers
> +being part of the infrastructure and provide common services for all leaves
> +found on all platforms.
> +
> +The driver object model looks like the following::
> +
> +                    +-----------+
> +                    |   xroot   |
> +                    +-----+-----+
> +                          |
> +              +-----------+-----------+
> +              |                       |
> +              v                       v
> +        +-----------+          +-----------+
> +        |   group   |    ...   |   group   |
> +        +-----+-----+          +------+----+
> +              |                       |
> +              |                       |
> +        +-----+----+            +-----+----+
> +        |          |            |          |
> +        v          v            v          v
> +    +-------+  +-------+    +-------+  +-------+
> +    | xleaf |..| xleaf |    | xleaf |..| xleaf |
> +    +-------+  +-------+    +-------+  +-------+
> +
> +As an example for Xilinx Alveo U50 before user xclbin download, the tree
> +looks like the following::
> +
> +                                +-----------+
> +                                |   xmgmt   |
> +                                +-----+-----+
> +                                      |
> +            +-------------------------+--------------------+
> +            |                         |                    |
> +            v                         v                    v
> +       +--------+                +--------+            +--------+
> +       | group0 |                | group1 |            | group2 |
> +       +----+---+                +----+---+            +---+----+
> +            |                         |                    |
> +            |                         |                    |
> +      +-----+-----+        +----+-----+---+    +-----+-----+----+--------+
> +      |           |        |    |         |    |     |          |        |
> +      v           v        |    v         v    |     v          v        |
> + +------------+  +------+  | +------+ +------+ |  +------+ +-----------+ |
> + | xmgmt_main |  | VSEC |  | | GPIO | | QSPI | |  |  CMC | | AXI-GATE0 | |
> + +------------+  +------+  | +------+ +------+ |  +------+ +-----------+ |
> +                           | +---------+       |  +------+ +-----------+ |
> +                           +>| MAILBOX |       +->| ICAP | | AXI-GATE1 |<+
> +                             +---------+       |  +------+ +-----------+
> +                                               |  +-------+
> +                                               +->| CALIB |
> +                                                  +-------+
> +
Nice ascii art!
> +After an xclbin is download, group3 will be added and the tree looks like the
> +following::
> +
> +                                +-----------+
> +                                |   xmgmt   |
> +                                +-----+-----+
> +                                      |
> +            +-------------------------+--------------------+-----------------+
> +            |                         |                    |                 |
> +            v                         v                    v                 |
> +       +--------+                +--------+            +--------+            |
> +       | group0 |                | group1 |            | group2 |            |
> +       +----+---+                +----+---+            +---+----+            |
> +            |                         |                    |                 |
> +            |                         |                    |                 |
> +      +-----+-----+       +-----+-----+---+    +-----+-----+----+--------+   |
> +      |           |       |     |         |    |     |          |        |   |
> +      v           v       |     v         v    |     v          v        |   |
> + +------------+  +------+ | +------+ +------+  |  +------+ +-----------+ |   |
> + | xmgmt_main |  | VSEC | | | GPIO | | QSPI |  |  |  CMC | | AXI-GATE0 | |   |
> + +------------+  +------+ | +------+ +------+  |  +------+ +-----------+ |   |
> +                          | +---------+        |  +------+ +-----------+ |   |
> +                          +>| MAILBOX |        +->| ICAP | | AXI-GATE1 |<+   |
> +                            +---------+        |  +------+ +-----------+     |
> +                                               |  +-------+                  |
> +                                               +->| CALIB |                  |
> +                                                  +-------+                  |
> +                      +---+----+                                             |
> +                      | group3 |<--------------------------------------------+
> +                      +--------+
> +                          |
> +                          |
> +     +-------+--------+---+--+--------+------+-------+
> +     |       |        |      |        |      |       |
> +     v       |        v      |        v      |       v
> + +--------+  |   +--------+  |   +--------+  |    +-----+
> + | CLOCK0 |  |   | CLOCK1 |  |   | CLOCK2 |  |    | UCS |
> + +--------+  v   +--------+  v   +--------+  v    +-----+
> + +-------------+ +-------------+ +-------------+
> + | CLOCK-FREQ0 | | CLOCK-FREQ1 | | CLOCK-FREQ2 |
> + +-------------+ +-------------+ +-------------+
> +
> +
> +xmgmt-root
> +^^^^^^^^^^
> +
> +The xmgmt-root driver is a PCIe device driver attached to MPF. It's part of the
> +infrastructure of the MPF driver and resides in xmgmt.ko. This driver
> +
> +* manages one or more group drivers
> +* provides access to functionalities that requires pci_dev, such as PCIE config
> +  space access, to other xleaf drivers through root calls
> +* together with group driver, facilities event callbacks for other xleaf drivers
> +* together with group driver, facilities inter-leaf driver calls for other xleaf
Maybe drop 'together with group driver'
> +  drivers
> +
> +When root driver starts, it will explicitly create an initial group instance,
> +which contains xleaf drivers that will trigger the creation of other group
> +instances. The root driver will wait for all group and leaves to be created
> +before it returns from it's probe routine and claim success of the
> +initialization of the entire xmgmt driver.
What happens if there a failure in one leaf ? Does the whole board go down ?
> +
> +.. note::
> +   See code in ``lib/xroot.c`` and ``mgmt/root.c``
> +
> +
> +group
> +^^^^^
> +
> +The group driver is a platform device driver whose life cycle is managed by
Maybe call this a 'pseudo device'
> +root and does not have real IO mem or IRQ resources. It's part of the
> +infrastructure of the MPF driver and resides in xrt-lib.ko. This driver
> +
> +* manages one or more xleaf drivers so that multiple leaves can be managed as a
> +  group
can drop 'so that multiple leaves can be managed as a group' to me, this is the same as 'one or more'
> +* provides access to root from leaves, so that root calls, event notifications
> +  and inter-leaf calls can happen
> +
> +In xmgmt, an initial group driver instance will be created by root, which
by the root
> +contains leaves that will trigger group instances to be created to manage
> +groups of leaves found on different partitions on hardware, such as VSEC, Shell,
> +and User.
> +
> +Every *fpga_region* has a group object associated with it. The group is
> +created when xclbin image is loaded on the fpga_region. The existing group
> +is destroyed when a new xclbin image is loaded. The fpga_region persists
> +across xclbin downloads.
The connection of a 'group' node to a fpga region region is fairly important, maybe move this section earlier. 'group' as an fpganess thing would be kept in fpga/ subsystem.
> +
> +.. note::
> +   See code in ``lib/group.c``
> +
> +
> +xleaf
> +^^^^^
> +
> +The xleaf driver is a platform device driver whose life cycle is managed by
> +a group driver and may or may not have real IO mem or IRQ resources. They
> +are the real meat of xmgmt and contains platform specific code to Shell and
> +User found on a MPF.
> +

Maybe a split is pseudo device leaves, those without real IO mem, stay in fpga/  others go ?

> +A xleaf driver may not have real hardware resources when it merely acts as a
> +driver that manages certain in-memory states for xmgmt. These in-memory states
> +could be shared by multiple other leaves.
> +
This implies locking and some message passing.
> +Leaf drivers assigned to specific hardware resources drive specific subsystem in
drive a specific
> +the device. To manipulate the subsystem or carry out a task, a xleaf driver may
> +ask help from root via root calls and/or from other leaves via inter-leaf calls.
> +
> +A xleaf can also broadcast events through infrastructure code for other leaves
> +to process. It can also receive event notification from infrastructure about
> +certain events, such as post-creation or pre-exit of a particular xleaf.
I would like to see some examples of how the inter node communications work.
> +
> +.. note::
> +   See code in ``lib/xleaf/*.c``
> +
> +
> +FPGA Manager Interaction
> +========================
> +
> +fpga_manager
> +------------
> +
> +An instance of fpga_manager is created by xmgmt_main and is used for xclbin
for the xclbin
> +image download. fpga_manager requires the full xclbin image before it can
> +start programming the FPGA configuration engine via ICAP platform driver.

via the ICAP

what is ICAP ?

> +
> +fpga_region
> +-----------
> +
> +For every interface exposed by currently loaded xclbin/xsabin in the *parent*
by the currently
> +fpga_region a new instance of fpga_region is created like a *child* region.
fpga_region,
> +The device tree of the *parent* fpga_region defines the
> +resources for a new instance of fpga_bridge which isolates the parent from
and isolates
> +child fpga_region. This new instance of fpga_bridge will be used when a
> +xclbin image is loaded on the child fpga_region. After the xclbin image is
> +downloaded to the fpga_region, an instance of group is created for the
> +fpga_region using the device tree obtained as part of xclbin. If this device
of the xclbin
> +tree defines any child interfaces then it can trigger the creation of
interfaces, then
> +fpga_bridge and fpga_region for the next region in the chain.
a fpga_bridge and a fpga_region
> +
> +fpga_bridge
> +-----------
> +
> +Like fpga_region, matching fpga_bridge is also created by walking the device
Like the fpga_region, a matchin
> +tree of the parent group.
> +
> +Driver Interfaces
> +=================
> +
> +xmgmt Driver Ioctls
> +-------------------
> +
> +Ioctls exposed by xmgmt driver to user space are enumerated in the following
> +table:
> +
> +== ===================== ============================ ==========================
> +#  Functionality         ioctl request code            data format
> +== ===================== ============================ ==========================
> +1  FPGA image download   XMGMT_IOCICAPDOWNLOAD_AXLF    xmgmt_ioc_bitstream_axlf
> +== ===================== ============================ ==========================

This data format is described below, maybe swap this section with that so

folks will know what xmgmnt_ioc_bitstream_axlf is before this section.

> +
> +User xclbin can be downloaded by using xbmgmt tool from XRT open source suite. See

A user xclbin

using the xbmgmt

from the XRT

> +example usage below::
> +
> +  xbmgmt partition --program --path /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/test/verify.xclbin --force
> +
> +xmgmt Driver Sysfs
> +------------------
> +
> +xmgmt driver exposes a rich set of sysfs interfaces. Subsystem platform
> +drivers export sysfs node for every platform instance.
> +
> +Every partition also exports its UUIDs. See below for examples::
> +
> +  /sys/bus/pci/devices/0000:06:00.0/xmgmt_main.0/interface_uuids
> +  /sys/bus/pci/devices/0000:06:00.0/xmgmt_main.0/logic_uuids
> +
> +
> +hwmon
> +-----
> +
> +xmgmt driver exposes standard hwmon interface to report voltage, current,
> +temperature, power, etc. These can easily be viewed using *sensors* command
> +line utility.
> +
> +Alveo Platform Overview
> +=======================
> +
> +Alveo platforms are architected as two physical FPGA partitions: *Shell* and
> +*User*. The Shell provides basic infrastructure for the Alveo platform like
> +PCIe connectivity, board management, Dynamic Function Exchange (DFX), sensors,
> +clocking, reset, and security. User partition contains user compiled FPGA
the user compiled
> +binary which is loaded by a process called DFX also known as partial
> +reconfiguration.
> +
> +Physical partitions require strict HW compatibility with each other for DFX to
> +work properly. 

swap order

For DFX to work properly physical partitions ..


> Every physical partition has two interface UUIDs: *parent* UUID
> +and *child* UUID. For simple single stage platforms, Shell → User forms parent
> +child relationship. For complex two stage platforms, Base → Shell → User forms
> +the parent child relationship chain.
this bit is confusing. is this related to uuid?
> +
> +.. note::
> +   Partition compatibility matching is key design component of Alveo platforms
> +   and XRT. Partitions have child and parent relationship. A loaded partition
have a child
> +   exposes child partition UUID to advertise its compatibility requirement for

the child's

can drop 'for child partition'

> +   child partition. When loading a child partition the xmgmt management driver
When loading a child partition,
> +   matches parent UUID of the child partition against child UUID exported by
> +   the parent. Parent and child partition UUIDs are stored in the *xclbin*
> +   (for user) or *xsabin* (for base and shell).

this is confusing, is this part of the file image format ?

Maybe save/move till the image layout.

>  Except for root UUID, VSEC,
> +   hardware itself does not know about UUIDs. UUIDs are stored in xsabin and
> +   xclbin.
This is confusing too, not sure how to untangle.
> +
> +
> +The physical partitions and their loading is illustrated below::
> +
> +           SHELL                               USER
> +        +-----------+                  +-------------------+
> +        |           |                  |                   |
> +        | VSEC UUID | CHILD     PARENT |    LOGIC UUID     |
> +        |           o------->|<--------o                   |
> +        |           | UUID       UUID  |                   |
> +        +-----+-----+                  +--------+----------+
> +              |                                 |
> +              .                                 .
> +              |                                 |
> +          +---+---+                      +------+--------+
> +          |  POR  |                      | USER COMPILED |
> +          | FLASH |                      |    XCLBIN     |
> +          +-------+                      +---------------+
> +
> +
> +Loading Sequence
> +----------------
> +
> +The Shell partition is loaded from flash at system boot time. It establishes the
> +PCIe link and exposes two physical functions to the BIOS. After OS boot, xmgmt
the OS boots, the xmgmt
> +driver attaches to PCIe physical function 0 exposed by the Shell and then looks
> +for VSEC in PCIe extended configuration space. Using VSEC it determines the logic

the PCIe

The driver uses VSEC to determine the UUID of Shell.  The UUID is also used to load a matching ...

> +UUID of Shell and uses the UUID to load matching *xsabin* file from Linux firmware
> +directory. The xsabin file contains metadata to discover peripherals that are part
> +of Shell and firmware(s) for any embedded soft processors in Shell.
the firmware needed for any ...
> +
> +The Shell exports child interface UUID which is used for compatibility check when

export a child

for a compatibility check

> +loading user compiled xclbin over the User partition as part of DFX. When a user
> +requests loading of a specific xclbin the xmgmt management driver reads the parent
xclbin, the
> +interface UUID specified in the xclbin and matches it with child interface UUID
> +exported by Shell to determine if xclbin is compatible with the Shell. If match
> +fails loading of xclbin is denied.
> +
> +xclbin loading is requested using ICAP_DOWNLOAD_AXLF ioctl command. When loading
> +xclbin, xmgmt driver performs the following *logical* operations:
> +
> +1. Copy xclbin from user to kernel memory
> +2. Sanity check the xclbin contents
> +3. Isolate the User partition
> +4. Download the bitstream using the FPGA config engine (ICAP)
> +5. De-isolate the User partition
> +6. Program the clocks (ClockWiz) driving the User partition
maybe drop '(ClockWiz)'
> +7. Wait for memory controller (MIG) calibration
for the
> +8. Return the loading status back to the caller
> +
> +`Platform Loading Overview <https://xilinx.github.io/XRT/master/html/platforms_partitions.html>`_
> +provides more detailed information on platform loading.
> +
the link works.
> +
> +xsabin
> +------
> +
> +Each Alveo platform comes packaged with its own xsabin. The xsabin is trusted
is a trusted
> +component of the platform. For format details refer to :ref:`xsabin_xclbin_container_format`
> +below. xsabin contains basic information like UUIDs, platform name and metadata in the
> +form of device tree. See :ref:`device_tree_usage` below for details and example.
of a device
> +
> +xclbin
> +------
> +
> +xclbin is compiled by end user using
> +`Vitis <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
this link works, seems reasonable landing
> +tool set from Xilinx. The xclbin contains sections describing user compiled
> +acceleration engines/kernels, memory subsystems, clocking information etc. It also
> +contains bitstream for the user partition, UUIDs, platform name, etc. xclbin uses
bitstreams
> +the same container format as xsabin which is described below.
> +
> +
> +.. _xsabin_xclbin_container_format:
> +
> +xsabin/xclbin Container Format
> +------------------------------
> +
> +xclbin/xsabin is ELF-like binary container format. It is structured as series of
> +sections. There is a file header followed by several section headers which is
> +followed by sections. A section header points to an actual section. There is an
> +optional signature at the end. The format is defined by header file ``xclbin.h``.
> +The following figure illustrates a typical xclbin::
> +
> +
> +           +---------------------+
> +           |                     |
> +           |       HEADER        |
> +           +---------------------+
> +           |   SECTION  HEADER   |
> +           |                     |
> +           +---------------------+
> +           |         ...         |
> +           |                     |
> +           +---------------------+
> +           |   SECTION  HEADER   |
> +           |                     |
> +           +---------------------+
> +           |       SECTION       |
> +           |                     |
> +           +---------------------+
> +           |         ...         |
> +           |                     |
> +           +---------------------+
> +           |       SECTION       |
> +           |                     |
> +           +---------------------+
> +           |      SIGNATURE      |
> +           |      (OPTIONAL)     |
> +           +---------------------+
> +
> +
> +xclbin/xsabin files can be packaged, un-packaged and inspected using XRT utility
> +called **xclbinutil**. xclbinutil is part of XRT open source software stack. The
> +source code for xclbinutil can be found at
> +https://github.com/Xilinx/XRT/tree/master/src/runtime_src/tools/xclbinutil
> +
Works, but maybe the location of a manpage or doc would be better.
> +For example to enumerate the contents of a xclbin/xsabin use the *--info* switch
> +as shown below::
> +
> +
> +  xclbinutil --info --input /opt/xilinx/firmware/u50/gen3x16-xdma/blp/test/bandwidth.xclbin
> +  xclbinutil --info --input /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/partition.xsabin
> +
> +
> +.. _device_tree_usage:
> +
> +Device Tree Usage
> +-----------------
> +
> +As mentioned previously xsabin stores metadata which advertise HW subsystems present
> +in a partition. The metadata is stored in device tree format with well defined schema.
> +XRT management driver uses this information to bind *platform drivers* to the subsystem
> +instantiations. The platform drivers are found in **xrt-lib.ko** kernel module defined
> +later.
> +
> +Logic UUID
> +^^^^^^^^^^
> +A partition is identified uniquely through ``logic_uuid`` property::
> +
> +  /dts-v1/;
> +  / {
> +      logic_uuid = "0123456789abcdef0123456789abcdef";
> +      ...
> +    }
> +
> +Schema Version
> +^^^^^^^^^^^^^^
> +Schema version is defined through ``schema_version`` node. And it contains ``major``
> +and ``minor`` properties as below::
> +
> +  /dts-v1/;
> +  / {
> +       schema_version {
> +           major = <0x01>;
> +           minor = <0x00>;
> +       };
> +       ...
> +    }
> +
> +Partition UUIDs
> +^^^^^^^^^^^^^^^
> +As said earlier, each partition may have parent and child UUIDs. These UUIDs are
> +defined by ``interfaces`` node and ``interface_uuid`` property::
> +
> +  /dts-v1/;
> +  / {
> +       interfaces {
> +           @0 {
> +                  interface_uuid = "0123456789abcdef0123456789abcdef";
> +           };
> +           @1 {
> +                  interface_uuid = "fedcba9876543210fedcba9876543210";
> +           };
> +           ...
> +        };
> +       ...
> +    }
> +
> +
> +Subsystem Instantiations
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +Subsystem instantiations are captured as children of ``addressable_endpoints``
> +node::
> +
> +  /dts-v1/;
> +  / {
> +       addressable_endpoints {
> +           abc {
> +               ...
> +           };
> +           def {
> +               ...
> +           };
> +           ...
> +       }
> +  }
> +
> +Subnode 'abc' and 'def' are the name of subsystem nodes
> +
> +Subsystem Node
> +^^^^^^^^^^^^^^
> +Each subsystem node and its properties define a hardware instance::
> +
> +
> +  addressable_endpoints {
> +      abc {
> +          reg = <0xa 0xb>
> +          pcie_physical_function = <0x0>;
> +          pcie_bar_mapping = <0x2>;
> +          compatible = "abc def";
> +          firmware {
> +              firmware_product_name = "abc"
> +              firmware_branch_name = "def"
> +              firmware_version_major = <1>
> +              firmware_version_minor = <2>
> +          };
> +      }
> +      ...
> +  }
> +
> +:reg:
> + Property defines address range. '<0xa 0xb>' is BAR offset and length pair, both
> + are 64-bit integer.
> +:pcie_physical_function:
> + Property specifies which PCIe physical function the subsystem node resides.
> +:pcie_bar_mapping:
> + Property specifies which PCIe BAR the subsystem node resides. '<0x2>' is BAR
> + index and it is 0 if this property is not defined.
> +:compatible:
> + Property is a list of strings. The first string in the list specifies the exact
> + subsystem node. The following strings represent other devices that the device
> + is compatible with.
> +:firmware:
> + Subnode defines the firmware required by this subsystem node.
> +
> +Alveo U50 Platform Example
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +::
> +
> +  /dts-v1/;
> +
> +  /{
> +        logic_uuid = "f465b0a3ae8c64f619bc150384ace69b";
> +
> +        schema_version {
> +                major = <0x01>;
> +                minor = <0x00>;
> +        };
> +
> +        interfaces {
> +
> +                @0 {
> +                        interface_uuid = "862c7020a250293e32036f19956669e5";
> +                };
> +        };
> +
> +        addressable_endpoints {
> +
> +                ep_blp_rom_00 {
> +                        reg = <0x00 0x1f04000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> +                };
> +
> +                ep_card_flash_program_00 {
> +                        reg = <0x00 0x1f06000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_quad_spi-1.0\0axi_quad_spi";
> +                        interrupts = <0x03 0x03>;
> +                };
> +
> +                ep_cmc_firmware_mem_00 {
> +                        reg = <0x00 0x1e20000 0x00 0x20000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> +
> +                        firmware {
> +                                firmware_product_name = "cmc";
> +                                firmware_branch_name = "u50";
> +                                firmware_version_major = <0x01>;
> +                                firmware_version_minor = <0x00>;
> +                        };
> +                };
> +
> +                ep_cmc_intc_00 {
> +                        reg = <0x00 0x1e03000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
> +                        interrupts = <0x04 0x04>;
> +                };
> +
> +                ep_cmc_mutex_00 {
> +                        reg = <0x00 0x1e02000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_cmc_regmap_00 {
> +                        reg = <0x00 0x1e08000 0x00 0x2000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> +
> +                        firmware {
> +                                firmware_product_name = "sc-fw";
> +                                firmware_branch_name = "u50";
> +                                firmware_version_major = <0x05>;
> +                        };
> +                };
> +
> +                ep_cmc_reset_00 {
> +                        reg = <0x00 0x1e01000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_ddr_mem_calib_00 {
> +                        reg = <0x00 0x63000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_debug_bscan_mgmt_00 {
> +                        reg = <0x00 0x1e90000 0x00 0x10000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-debug_bridge-1.0\0debug_bridge";
> +                };
> +
> +                ep_ert_base_address_00 {
> +                        reg = <0x00 0x21000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_ert_command_queue_mgmt_00 {
> +                        reg = <0x00 0x40000 0x00 0x10000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
> +                };
> +
> +                ep_ert_command_queue_user_00 {
> +                        reg = <0x00 0x40000 0x00 0x10000>;
> +                        pcie_physical_function = <0x01>;
> +                        compatible = "xilinx.com,reg_abs-ert_command_queue-1.0\0ert_command_queue";
> +                };
> +
> +                ep_ert_firmware_mem_00 {
> +                        reg = <0x00 0x30000 0x00 0x8000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> +
> +                        firmware {
> +                                firmware_product_name = "ert";
> +                                firmware_branch_name = "v20";
> +                                firmware_version_major = <0x01>;
> +                        };
> +                };
> +
> +                ep_ert_intc_00 {
> +                        reg = <0x00 0x23000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_intc-1.0\0axi_intc";
> +                        interrupts = <0x05 0x05>;
> +                };
> +
> +                ep_ert_reset_00 {
> +                        reg = <0x00 0x22000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_ert_sched_00 {
> +                        reg = <0x00 0x50000 0x00 0x1000>;
> +                        pcie_physical_function = <0x01>;
> +                        compatible = "xilinx.com,reg_abs-ert_sched-1.0\0ert_sched";
> +                        interrupts = <0x09 0x0c>;
> +                };
> +
> +                ep_fpga_configuration_00 {
> +                        reg = <0x00 0x1e88000 0x00 0x8000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_hwicap-1.0\0axi_hwicap";
> +                        interrupts = <0x02 0x02>;
> +                };
> +
> +                ep_icap_reset_00 {
> +                        reg = <0x00 0x1f07000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_msix_00 {
> +                        reg = <0x00 0x00 0x00 0x20000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-msix-1.0\0msix";
> +                        pcie_bar_mapping = <0x02>;
> +                };
> +
> +                ep_pcie_link_mon_00 {
> +                        reg = <0x00 0x1f05000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_pr_isolate_plp_00 {
> +                        reg = <0x00 0x1f01000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_pr_isolate_ulp_00 {
> +                        reg = <0x00 0x1000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_gpio-1.0\0axi_gpio";
> +                };
> +
> +                ep_uuid_rom_00 {
> +                        reg = <0x00 0x64000 0x00 0x1000>;
> +                        pcie_physical_function = <0x00>;
> +                        compatible = "xilinx.com,reg_abs-axi_bram_ctrl-1.0\0axi_bram_ctrl";
> +                };
> +
> +                ep_xdma_00 {
> +                        reg = <0x00 0x00 0x00 0x10000>;
> +                        pcie_physical_function = <0x01>;
> +                        compatible = "xilinx.com,reg_abs-xdma-1.0\0xdma";
> +                        pcie_bar_mapping = <0x02>;
> +                };
> +        };
> +
> +  }
> +
> +
> +
> +Deployment Models
> +=================
> +
> +Baremetal
> +---------
> +
> +In bare-metal deployments both MPF and UPF are visible and accessible. xmgmt
In bare-meta deployments,
> +driver binds to MPF. xmgmt driver operations are privileged and available to
> +system administrator. The full stack is illustrated below::
> +
> +                            HOST
> +
> +                 [XMGMT]            [XUSER]
> +                    |                  |
> +                    |                  |
> +                 +-----+            +-----+
> +                 | MPF |            | UPF |
> +                 |     |            |     |
> +                 | PF0 |            | PF1 |
> +                 +--+--+            +--+--+
> +          ......... ^................. ^..........
> +                    |                  |
> +                    |   PCIe DEVICE    |
> +                    |                  |
> +                 +--+------------------+--+
> +                 |         SHELL          |
> +                 |                        |
> +                 +------------------------+
> +                 |         USER           |
> +                 |                        |
> +                 |                        |
> +                 |                        |
> +                 |                        |
> +                 +------------------------+
> +
> +
> +
> +Virtualized
> +-----------
> +
> +In virtualized deployments privileged MPF is assigned to host but unprivileged
In virtualized deployments, the
> +UPF is assigned to guest VM via PCIe pass-through. xmgmt driver in host binds
in the host
> +to MPF. xmgmt driver operations are privileged and only accessible by hosting
to the MPF
> +service provider. The full stack is illustrated below::
> +
> +
> +                                 .............
> +                  HOST           .    VM     .
> +                                 .           .
> +                 [XMGMT]         .  [XUSER]  .
> +                    |            .     |     .
> +                    |            .     |     .
> +                 +-----+         .  +-----+  .
> +                 | MPF |         .  | UPF |  .
> +                 |     |         .  |     |  .
> +                 | PF0 |         .  | PF1 |  .
> +                 +--+--+         .  +--+--+  .
> +          ......... ^................. ^..........
> +                    |                  |
> +                    |   PCIe DEVICE    |
> +                    |                  |
> +                 +--+------------------+--+
> +                 |         SHELL          |
> +                 |                        |
> +                 +------------------------+
> +                 |         USER           |
> +                 |                        |
> +                 |                        |
> +                 |                        |
> +                 |                        |
> +                 +------------------------+
> +
> +
> +
> +
> +
> +Platform Security Considerations
> +================================
> +
> +`Security of Alveo Platform <https://xilinx.github.io/XRT/master/html/security.html>`_
> +discusses the deployment options and security implications in great detail.

This link works and looks great.

Tom

