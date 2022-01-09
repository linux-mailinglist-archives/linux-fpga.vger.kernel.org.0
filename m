Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D7D488B65
	for <lists+linux-fpga@lfdr.de>; Sun,  9 Jan 2022 18:38:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbiAIRiY (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 9 Jan 2022 12:38:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:25421 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234382AbiAIRiX (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Sun, 9 Jan 2022 12:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641749901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q6SCpnfcFIbX+2i9xfjEE4uwCQmCaX8uGwzgDH9LD1M=;
        b=fmpJtzeXrxVV4gJBoZ9LXZsO+yPa2B050UYEdX0QCLncKq7Vri17Nc3cvj4B5kcgcfRVZS
        VZp6KrkXikvXLIAC8tee5fnn7cjNh7VD0/GQXasanJLpeoQnm3JDr8SeCqj7MwiZkbAVpg
        lgAxa+aTvFEGCmoeh0SguIBJ0E7uMu0=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-637-QddhGahqMEKKdvAWzBtw4w-1; Sun, 09 Jan 2022 12:38:20 -0500
X-MC-Unique: QddhGahqMEKKdvAWzBtw4w-1
Received: by mail-oo1-f69.google.com with SMTP id l6-20020a4abe06000000b002dab9d33f2eso7756234oop.0
        for <linux-fpga@vger.kernel.org>; Sun, 09 Jan 2022 09:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=q6SCpnfcFIbX+2i9xfjEE4uwCQmCaX8uGwzgDH9LD1M=;
        b=m8f/zPx7hARqV5E9/YzsfgFcRLNTX0qLFKZtumfO1H5gOX7LMPC9aLgo7x/CbcK2eO
         7J/2UseK09QzQXKQphKiS4yLwHL6hXsuuf0pU0NkIMzqEIBGBCRh+gENmuffhVB4IrZB
         tJAsQ9ZUhNe5Oe4c/5HrgVGDHVJSnhNLvxiAxx4LCjG5rB658u5clDSt6hYz27ztvTDq
         e2wj020FxEffwK5jejAmQbCk2uuZPCxYID+gP2lDnlnW2N1nTJyEmrQnmor4JkIEOOfS
         uGxfjN6JtnmQMbN8Z/SAgfZhKiTG8ee8Zr8NlqVUk6qnSMQigv0sObIBfP4ldgHgSVVw
         Wsyw==
X-Gm-Message-State: AOAM532zl5dUhK2lQg1cWOLigLdFW8Q4tshjqvDzhqgCCwtjuLXBY+3Q
        FdVzRTfi+79FCmBDv22gJjfvqUsA90/kKs/b8mlsR1zh8ASiuPA1GVrgmWGYCOyxCpuvG365OUi
        i3u9MhhEg14BYlmOvZviAYg==
X-Received: by 2002:a9d:6a89:: with SMTP id l9mr6658785otq.267.1641749899465;
        Sun, 09 Jan 2022 09:38:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyOSZEgbr+UBofZ9g4LokLKyKRWm4i6XjvlCkjq3cZqPZgZb+bqANtW6ScnoaBuKtTgePaZBA==
X-Received: by 2002:a9d:6a89:: with SMTP id l9mr6658774otq.267.1641749899019;
        Sun, 09 Jan 2022 09:38:19 -0800 (PST)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id r17sm996354otc.65.2022.01.09.09.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jan 2022 09:38:18 -0800 (PST)
Subject: Re: [PATCH V4 XRT Alveo Infrastructure 1/5] Documentation: fpga: Add
 a document describing XRT Alveo driver infrastructure
To:     Lizhi Hou <lizhi.hou@xilinx.com>, linux-kernel@vger.kernel.org
Cc:     linux-fpga@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, devicetree@vger.kernel.org, mdf@kernel.org,
        robh@kernel.org, dwmw2@infradead.org,
        Max Zhen <max.zhen@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
 <20220105225013.1567871-2-lizhi.hou@xilinx.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <4beb977c-a172-20ef-21f6-7336f4406b1b@redhat.com>
Date:   Sun, 9 Jan 2022 09:38:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220105225013.1567871-2-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org


On 1/5/22 2:50 PM, Lizhi Hou wrote:
> Describe XRT driver architecture and provide basic overview of
> Xilinx Alveo platform.
>
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>   Documentation/fpga/index.rst |   1 +
>   Documentation/fpga/xrt.rst   | 337 +++++++++++++++++++++++++++++++++++
>   MAINTAINERS                  |  10 ++
>   3 files changed, 348 insertions(+)
>   create mode 100644 Documentation/fpga/xrt.rst
>
> diff --git a/Documentation/fpga/index.rst b/Documentation/fpga/index.rst
> index f80f95667ca2..30134357b70d 100644
> --- a/Documentation/fpga/index.rst
> +++ b/Documentation/fpga/index.rst
> @@ -8,6 +8,7 @@ fpga
>       :maxdepth: 1
>   
>       dfl
> +    xrt
>   
>   .. only::  subproject and html
>   
> diff --git a/Documentation/fpga/xrt.rst b/Documentation/fpga/xrt.rst
> new file mode 100644
> index 000000000000..45d6f2e18af0
> --- /dev/null
> +++ b/Documentation/fpga/xrt.rst
> @@ -0,0 +1,337 @@
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
> +XRTV2 drivers support *subsystem* style data driven platforms where the driver's
> +configuration and behavior are determined by the metadata provided by the
> +platform (in *device tree* format). Primary management physical function (MPF)
> +driver is called **xrt-mgmt**. Primary user physical function (UPF) driver is
> +called **xrt-user** and is under development. xrt_driver common APIs are packaged
> +into a library module called **xrt-lib**, which is shared by **xrt-mgmt** and
> +**xrt-user** (under development).
> +
> +Driver Modules
> +==============
> +
> +xrt-lib.ko
> +----------
> +
> +xrt-lib is the repository of functions that can potentially be shared between
> +xrt-mgmt and xrt-user.
> +
> +Alveo platform consists of one or more FPGA partitions. Each partition has
> +multiple HW peripherals (also referred to as endpoints) and metadata to describe
> +the endpoints. This metadata is in flat device tree format. xrt-lib relies on OF
> +kernel APIs to un-flatten the metadata and overlay the un-flattened device tree
> +nodes to the system base device tree.
to -> onto
> +
> +xrt-mgmt.ko
> +------------
> +
> +The xrt-mgmt driver is a PCIe device driver driving MPF found on Xilinx's Alveo
driving -> for a
> +PCIe device. It reads Alveo platform partition metadata and creates one or more
> +partitions based on the hardware design. xrt-lib APIs are called to overlay the
> +endpoint nodes to the system base tree. Eventually, platform devices are
> +generated for each endpoint defined in the partition metadata.
> +
> +The xrt-mgmt driver uses xrt-lib APIs to manage the life cycle of partitions,
> +which, in turn, manages multiple endpoints (platform devices) generated during
> +partition creation. This flexibility allows xrt-mgmt.ko and xrt-lib.ko to support
> +various HW subsystems exposed by different Alveo shells. The differences among
define 'shells'
> +these Alveo shells is handled in the endpoint (platform device) drivers.
> +See :ref:`alveo_platform_overview`.
> +
> +The instantiation of a specific endpoint driver is completely data driven based
> +on the metadata (in the device tree format). The flattened device tree is stored
> +in a xsabin file which is discovered through the PCIe VSEC capability.
> +
> +
> +Driver Object Model
> +===================
> +
> +The system device tree after overlaying Alveo partitions looks like the
> +following::
> +
> +                            +-----------+
> +                            |  of root  |
> +                            +-----------+
> +                                  |
> +              +-------------------+-------------------+
> +              |                   |                   |
> +              v                   v                   v
> +      +-------------+      +------------+        +---------+
> +      | xrt-part0   |      | xrt-partN  |        |         |
> +      |(simple-bus) |  ... |(simple-bus)|        |   ...   |
> +      +-------------+      +------------+        +---------+
> +              |                   |
> +              |                   |
> +        +-----+--------+          |
> +        |              |          |
> +        v              v          v
> +  +-----------+  +-----------+  +------------+
> +  |ep_foo@123 |..|ep_bar@456 |  | ep_foo@789 |
> +  +-----------+  +-----------+  +------------+
> +
> +partition node
> +--------------
> +
> +The partition node is created and added to the system device tree when the driver
> +creates a new partition. It is compatible with ``simple-bus`` which is a
> +transparent bus node defined by Linux kernel. The partition node is used for
maybe drop 'defined by Linux kernel'
> +translating the address of underneath endpoint to CPU address.
address -> addresses
> +
> +endpoint node
> +-------------
> +
> +During the partition creation, xrt driver un-flattens the partition metadata and
> +adds all the endpoint nodes under the partition node to the system device tree.
> +Eventually, all the endpoint nodes will be populated by the existing platform
> +device and OF infrastructure. This means a platform device will be created for
> +each endpoint node. The platform driver will be bound based on the ``compatible``
> +property defined in the endpoint node.
> +
> +.. _alveo_platform_overview:
> +
> +Alveo Platform Overview
> +=======================
> +
> +Alveo platforms are architected as two physical FPGA partitions: *Shell* and
shell is defined here but needed earlier, maybe move this section to earlier
> +*User*. The Shell provides basic infrastructure for the Alveo platform like
> +PCIe connectivity, board management, Dynamic Function Exchange (DFX), sensors,
> +clocking, reset, and security. DFX, partial reconfiguration, is responsible for
DFX also known as partial reconfiguration,
> +loading the user compiled FPGA binary.
> +
> +For DFX to work properly, physical partitions require strict HW compatibility
> +with each other. Every physical partition has two interface UUIDs: the *parent*
> +UUID and the *child* UUID. For simple single stage platforms, Shell → User forms
> +the parent child relationship.
> +
> +.. note::
> +   Partition compatibility matching is a key design component of the Alveo platforms
> +   and XRT. Partitions have child and parent relationship. A loaded partition
drop 'Partitions have child and parent relationship' , you just said 
this three lines up
> +   exposes child partition UUID to advertise its compatibility requirement. When
> +   loading a child partition, the xrt-mgmt driver matches the parent
> +   UUID of the child partition against the child UUID exported by the parent.
> +   The parent and child partition UUIDs are stored in the *xclbin* (for the user)
> +   and the *xsabin* (for the shell). Except for the root UUID exported by VSEC,
> +   the hardware itself does not know about the UUIDs. The UUIDs are stored in
> +   xsabin and xclbin. The image format has a special node called Partition UUIDs
> +   which define the compatibility UUIDs.
> +
> +
> +The physical partitions and their loading are illustrated below::
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
> +PCIe link and exposes two physical functions to the BIOS. After the OS boots,
> +the xrt-mgmt driver attaches to the PCIe physical function 0 exposed by the Shell
> +and then looks for VSEC in the PCIe extended configuration space. Using VSEC, it
> +determines the logic UUID of the Shell and uses the UUID to load matching *xsabin*
> +file from Linux firmware directory. The xsabin file contains the metadata to
> +discover the peripherals that are part of the Shell and the firmware for any
> +embedded soft processors in the Shell. The xsabin file also contains Partition
> +UUIDs.
> +
> +The Shell exports a child interface UUID which is used for the compatibility
> +check when loading the user compiled xclbin over the User partition as part of DFX.
> +When a user requests loading of a specific xclbin, the xrt-mgmt driver reads
> +the parent interface UUID specified in the xclbin and matches it with the child
> +interface UUID exported by the Shell to determine if the xclbin is compatible with
> +the Shell. If the match fails, loading of xclbin is denied.
> +
> +xclbin loading is requested using the ICAP_DOWNLOAD_AXLF ioctl command. When loading
> +a xclbin, the xrt-mgmt driver performs the following *logical* operations:
> +
> +1. Copy xclbin from user to kernel memory
> +2. Sanity check the xclbin contents
> +3. Isolate the User partition
> +4. Download the bitstream using the FPGA config engine (ICAP)
> +5. De-isolate the User partition
> +6. Program the clocks (ClockWiz) driving the User partition
> +7. Wait for the memory controller (MIG) calibration
> +8. Return the loading status back to the caller
> +
> +`Platform Loading Overview <https://xilinx.github.io/XRT/master/html/platforms_partitions.html>`_
> +provides more detailed information on platform loading.
> +
> +
> +xsabin
> +------
> +
> +Each Alveo platform comes packaged with its own xsabin. The xsabin is a trusted
> +component of the platform. For format details refer to :ref:`xsabin_xclbin_container_format`
> +below. xsabin contains basic information like UUIDs, platform name and metadata in the
> +form of flat device tree.
> +
> +xclbin
> +------
> +
> +xclbin is compiled by end user using
> +`Vitis <https://www.xilinx.com/products/design-tools/vitis/vitis-platform.html>`_
> +tool set from Xilinx. The xclbin contains sections describing user compiled
> +acceleration engines/kernels, memory subsystems, clocking information etc. It also
> +contains an FPGA bitstream for the user partition, UUIDs, platform name, etc.
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
> +optional signature at the end. The format is defined by the header file ``xclbin.h``.
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
> +xclbin/xsabin files can be packaged, un-packaged and inspected using an XRT
> +utility called **xclbinutil**. xclbinutil is part of the XRT open source
> +software stack. The source code for xclbinutil can be found at
> +https://github.com/Xilinx/XRT/tree/master/src/runtime_src/tools/xclbinutil
> +
> +For example, to enumerate the contents of a xclbin/xsabin use the *--info* switch
> +as shown below::
> +
> +
> +  xclbinutil --info --input /opt/xilinx/firmware/u50/gen3x16-xdma/blp/test/bandwidth.xclbin
> +  xclbinutil --info --input /lib/firmware/xilinx/862c7020a250293e32036f19956669e5/partition.xsabin
Two similar calls aren't needed, could drop one.
> +
> +Deployment Models
> +=================
> +
> +Baremetal
> +---------
> +
> +In bare-metal deployments, both MPF and UPF are visible and accessible. The
> +xrt-mgmt driver binds to MPF. The xrt-mgmt driver operations are privileged and
> +available to system administrator. The full stack is illustrated below::
> +
> +                            HOST
> +
> +               [XRT-MGMT]         [XRT-USER]
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
> +In virtualized deployments, the privileged MPF is assigned to the host but the
> +unprivileged UPF is assigned to a guest VM via PCIe pass-through. The xrt-mgmt
> +driver in host binds to MPF. The xrt-mgmt driver operations are privileged and
> +only accessible to the MPF. The full stack is illustrated below::
> +
> +
> +                                 ..............
> +                  HOST           .    VM      .
> +                                 .            .
> +               [XRT-MGMT]        . [XRT-USER] .
> +                    |            .     |      .
> +                    |            .     |      .
> +                 +-----+         .  +-----+   .
> +                 | MPF |         .  | UPF |   .
> +                 |     |         .  |     |   .
> +                 | PF0 |         .  | PF1 |   .
> +                 +--+--+         .  +--+--+   .
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
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 80eebc1d9ed5..fd7053bcfdb0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7369,6 +7369,16 @@ F:	Documentation/fpga/
>   F:	drivers/fpga/
>   F:	include/linux/fpga/
>   
> +FPGA XRT DRIVERS
> +M:	Lizhi Hou <lizhi.hou@xilinx.com>
> +R:	Max Zhen <max.zhen@xilinx.com>
> +R:	Sonal Santan <sonal.santan@xilinx.com>

Can you add me ?

R:    Tom Rix <trix@redhat.com>

> +L:	linux-fpga@vger.kernel.org
> +S:	Supported
> +W:	https://github.com/Xilinx/XRT

This should maybe be a T: since it is a git repo.

A better W: may be

https://xilinx.github.io/XRT/master/html/index.html

Tom

> +F:	Documentation/fpga/xrt.rst
> +F:	drivers/fpga/xrt/
> +
>   FPU EMULATOR
>   M:	Bill Metzenthen <billm@melbpc.org.au>
>   S:	Maintained

